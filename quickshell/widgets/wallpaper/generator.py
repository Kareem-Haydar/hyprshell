import sys
import argparse
from colorthief import ColorThief
from colorsys import rgb_to_hls, hls_to_rgb
import os
import json

def clamp(v, min_val, max_val):
    return max(min_val, min(max_val, v))

def adjust_chroma(rgb, min_chroma=0.2, max_chroma=0.9):
    """Ensure saturation is in vibrant range."""
    r, g, b = [x / 255.0 for x in rgb]
    h, l, s = rgb_to_hls(r, g, b)
    s = clamp(s, min_chroma, max_chroma)
    r, g, b = hls_to_rgb(h, l, s)
    return (int(r*255), int(g*255), int(b*255))

def rotate_hue(rgb, degrees):
    r, g, b = [x / 255.0 for x in rgb]
    h, l, s = rgb_to_hls(r, g, b)
    h = (h + degrees / 360.0) % 1.0
    r, g, b = hls_to_rgb(h, l, s)
    return (int(r*255), int(g*255), int(b*255))

def generate_tonal_palette(rgb, n_tones=13):
    """Generate tonal palette by varying lightness from dark (~0.1) to light (~0.95)"""
    r, g, b = [x / 255.0 for x in rgb]
    h, l, s = rgb_to_hls(r, g, b)
    tones = []
    # We generate 13 tones from lightness 0.95 (lightest) down to 0.1 (darkest)
    for i in range(n_tones):
        # tone index 0 is lightest, n_tones-1 darkest (reverse of typical)
        tone_lightness = 0.95 - (i * (0.85 / (n_tones - 1)))
        # Clamp lightness
        tone_lightness = clamp(tone_lightness, 0.0, 1.0)
        # Convert back to RGB
        rr, gg, bb = hls_to_rgb(h, tone_lightness, s)
        tones.append((int(rr*255), int(gg*255), int(bb*255)))
    return tones

def rgb_to_hex(rgb):
    return "#{:02x}{:02x}{:02x}".format(*rgb)

def choose_on_color(bg_rgb):
    """Choose black or white text color for best contrast with bg_rgb"""
    def luminance(c):
        c = c / 255.0
        return c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4
    R, G, B = [luminance(c) for c in bg_rgb]
    L = 0.2126 * R + 0.7152 * G + 0.0722 * B
    white = 1.0
    black = 0.0
    contrast_white = (white + 0.05) / (L + 0.05)
    contrast_black = (L + 0.05) / (black + 0.05)
    return (255,255,255) if contrast_white >= contrast_black else (0,0,0)

def generate_material_theme(image_path, dark_mode=False):
    ct = ColorThief(image_path)
    dominant = ct.get_color(quality=1)
    dominant = adjust_chroma(dominant, 0.35, 0.85)

    # Generate base palettes
    primary = dominant
    secondary = adjust_chroma(primary, 0.2, 0.5)
    tertiary = adjust_chroma(rotate_hue(primary, 60), 0.3, 0.7)
    neutral = adjust_chroma(primary, 0.05, 0.15)
    neutral_variant = adjust_chroma(primary, 0.1, 0.2)

    # Generate tonal palettes
    palettes = {
        "primary": generate_tonal_palette(primary),
        "secondary": generate_tonal_palette(secondary),
        "tertiary": generate_tonal_palette(tertiary),
        "neutral": generate_tonal_palette(neutral),
        "neutral_variant": generate_tonal_palette(neutral_variant),
    }

    def tone_idx_for(tone): 
        # Map 0..100 tone to index 0..12 (inverse)
        return clamp(12 - int(round(tone / 100 * 12)), 0, 12)

    roles = {}

    if dark_mode:
        # Dark theme roles - use lighter tones for primary elements, darker for backgrounds
        roles["primary"] = palettes["primary"][tone_idx_for(80)]  # Lighter primary
        roles["onPrimary"] = choose_on_color(roles["primary"])
        roles["primaryContainer"] = palettes["primary"][tone_idx_for(30)]  # Darker container
        roles["onPrimaryContainer"] = choose_on_color(roles["primaryContainer"])

        # Secondary roles (dark)
        roles["secondary"] = palettes["secondary"][tone_idx_for(80)]
        roles["onSecondary"] = choose_on_color(roles["secondary"])
        roles["secondaryContainer"] = palettes["secondary"][tone_idx_for(30)]
        roles["onSecondaryContainer"] = choose_on_color(roles["secondaryContainer"])

        # Tertiary roles (dark)
        roles["tertiary"] = palettes["tertiary"][tone_idx_for(80)]
        roles["onTertiary"] = choose_on_color(roles["tertiary"])
        roles["tertiaryContainer"] = palettes["tertiary"][tone_idx_for(30)]
        roles["onTertiaryContainer"] = choose_on_color(roles["tertiaryContainer"])

        # Dark backgrounds and surfaces
        roles["background"] = palettes["neutral"][tone_idx_for(10)]  # Very dark background
        roles["onBackground"] = choose_on_color(roles["background"])
        roles["surface"] = palettes["neutral"][tone_idx_for(10)]    # Dark surface
        roles["onSurface"] = choose_on_color(roles["surface"])
        roles["surfaceVariant"] = palettes["neutral_variant"][tone_idx_for(30)]
        roles["onSurfaceVariant"] = choose_on_color(roles["surfaceVariant"])
        roles["outline"] = palettes["neutral_variant"][tone_idx_for(60)]
        
        # Additional dark theme surfaces
        roles["surfaceContainer"] = palettes["neutral"][tone_idx_for(12)]
        roles["surfaceContainerHigh"] = palettes["neutral"][tone_idx_for(17)]
        roles["surfaceContainerHighest"] = palettes["neutral"][tone_idx_for(22)]
        
        # Error colors for dark theme
        roles["error"] = palettes["primary"][tone_idx_for(80)]  # Light error color
        roles["onError"] = choose_on_color(roles["error"])
        roles["errorContainer"] = palettes["primary"][tone_idx_for(30)]
        roles["onErrorContainer"] = choose_on_color(roles["errorContainer"])
        
    else:
        # Light theme roles - original implementation
        roles["primary"] = palettes["primary"][tone_idx_for(40)]
        roles["onPrimary"] = choose_on_color(roles["primary"])
        roles["primaryContainer"] = palettes["primary"][tone_idx_for(90)]
        roles["onPrimaryContainer"] = choose_on_color(roles["primaryContainer"])

        # Secondary roles (light)
        roles["secondary"] = palettes["secondary"][tone_idx_for(40)]
        roles["onSecondary"] = choose_on_color(roles["secondary"])
        roles["secondaryContainer"] = palettes["secondary"][tone_idx_for(90)]
        roles["onSecondaryContainer"] = choose_on_color(roles["secondaryContainer"])

        # Tertiary roles (light)
        roles["tertiary"] = palettes["tertiary"][tone_idx_for(40)]
        roles["onTertiary"] = choose_on_color(roles["tertiary"])
        roles["tertiaryContainer"] = palettes["tertiary"][tone_idx_for(90)]
        roles["onTertiaryContainer"] = choose_on_color(roles["tertiaryContainer"])

        # Light backgrounds and surfaces
        roles["background"] = palettes["neutral"][tone_idx_for(99)]
        roles["onBackground"] = choose_on_color(roles["background"])
        roles["surface"] = palettes["neutral"][tone_idx_for(98)]
        roles["onSurface"] = choose_on_color(roles["surface"])
        roles["surfaceVariant"] = palettes["neutral_variant"][tone_idx_for(90)]
        roles["onSurfaceVariant"] = choose_on_color(roles["surfaceVariant"])
        roles["outline"] = palettes["neutral_variant"][tone_idx_for(50)]
        
        # Additional light theme surfaces
        roles["surfaceContainer"] = palettes["neutral"][tone_idx_for(94)]
        roles["surfaceContainerHigh"] = palettes["neutral"][tone_idx_for(92)]
        roles["surfaceContainerHighest"] = palettes["neutral"][tone_idx_for(90)]
        
        # Error colors for light theme
        roles["error"] = palettes["primary"][tone_idx_for(40)]
        roles["onError"] = choose_on_color(roles["error"])
        roles["errorContainer"] = palettes["primary"][tone_idx_for(90)]
        roles["onErrorContainer"] = choose_on_color(roles["errorContainer"])

    # Convert all palettes to hex strings
    palettes_hex = {k: [rgb_to_hex(c) for c in v] for k,v in palettes.items()}
    roles_hex = {k: rgb_to_hex(v) for k,v in roles.items()}

    return {
        "source_color": rgb_to_hex(dominant),
        "scheme": "dark" if dark_mode else "light",
        "palettes": palettes_hex,
        "roles": roles_hex
    }

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate Material You theme from wallpaper")
    parser.add_argument("image_path", help="Path to the wallpaper image")
    parser.add_argument("-d", "--dark", action="store_true", help="Generate dark theme variant")
    parser.add_argument("-o", "--output", help="Output file path (default: ~/.cache/wallpaper-theme.json)")
    
    args = parser.parse_args()
    
    if not os.path.exists(args.image_path):
        print(f"Error: {args.image_path} does not exist.")
        sys.exit(1)
    
    theme = generate_material_theme(args.image_path, dark_mode=args.dark)
    
    # Determine output path
    if args.output:
        theme_path = os.path.expanduser(args.output)
    else:
        theme_path = os.path.expanduser(f"~/.cache/wallpaper-theme.json")
    
    with open(theme_path, "w") as f:
        json.dump(theme, f, indent=2)
    
    scheme_type = "dark" if args.dark else "light"
    print(f"Generated {scheme_type} theme from {args.image_path}")
    print(f"Saved to: {theme_path}")
    print(f"Source color: {theme['source_color']}")
