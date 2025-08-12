import os
import sys
from PySide6.QtCore import QObject, Slot, QStringListModel, Property, Signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QProcess
from PIL import Image
import subprocess

wallpaper_path = os.path.expanduser("~/.local/share/wallpapers")
thumbnail_path = os.path.expanduser("~/.cache/wallpaper-thumbnails")
os.makedirs(thumbnail_path, exist_ok=True)

def generate_thumbnail(input_path, size=(150, 90)):
    try:
        thumb_file = os.path.join(thumbnail_path, os.path.basename(input_path))
        if not os.path.exists(thumb_file):
            with Image.open(input_path) as img:
                img.thumbnail(size, Image.Resampling.LANCZOS)
                if img.mode in ("RGBA", "LA") or (img.mode == "P" and "transparency" in img.info):
                    # Convert image with alpha to RGB with white background
                    background = Image.new("RGB", img.size, (255, 255, 255))
                    background.paste(img, mask=img.split()[-1])  # paste using alpha channel as mask
                    img = background
                else:
                    img = img.convert("RGB")
                img.save(thumb_file, "JPEG", quality=85)
        return thumb_file
    except Exception as e:
        print("Failed to generate thumbnail for", input_path, ":", e)
        return ""

class WallpaperModel(QObject):
    wallpapersChanged = Signal()
    thumbnailsChanged = Signal()
    selectedChanged = Signal()  # Add this signal for the selected property
    isLoadingChanged = Signal()  # Signal for loading state

    def __init__(self):
        super().__init__()
        self._wallpapers = []
        self._thumbnails = []
        self._selected_path = ""  # Store the selected path
        self._is_loading = False  # Loading state
        self.load_wallpapers()

    def load_wallpapers(self):
        if os.path.exists(wallpaper_path):
            files = sorted(f for f in os.listdir(wallpaper_path) if f.lower().endswith((".png", ".jpg", ".jpeg")))
            self._wallpapers = [os.path.join(wallpaper_path, f) for f in files]
            # Generate thumbnails (or reuse cached)
            self._thumbnails = []
            for full_path in self._wallpapers:
                thumb = generate_thumbnail(full_path)
                if thumb:
                    self._thumbnails.append(thumb)
                else:
                    # fallback to full image if thumbnail generation failed
                    self._thumbnails.append(full_path)
            
            # Load the currently selected wallpaper
            try:
                with open(os.path.expanduser("~/.local/share/wallpapers/wallpaper.txt"), "r") as f:
                    self._selected_path = f.readline().strip()
            except FileNotFoundError:
                self._selected_path = ""
            
            self.wallpapersChanged.emit()
            self.thumbnailsChanged.emit()
            self.selectedChanged.emit()

    @Property("QStringList", notify=wallpapersChanged)
    def wallpapers(self):
        return self._wallpapers

    @Property("QStringList", notify=thumbnailsChanged)
    def thumbnails(self):
        return self._thumbnails

    @Property("QString", notify=selectedChanged)  # Use the correct signal
    def selected(self):
        return self._selected_path

    @Property(bool, notify=isLoadingChanged)
    def isLoading(self):
        return self._is_loading

    def _set_loading(self, loading):
        if self._is_loading != loading:
            self._is_loading = loading
            self.isLoadingChanged.emit()

    @Slot()
    def refresh(self):
        self.load_wallpapers()

    @Slot(str)
    def set_wallpaper(self, path):
        # Set loading state
        self._set_loading(True)
        
        # Write to file
        filepath = os.path.expanduser("~/.local/share/wallpapers/wallpaper.txt")
        with open(filepath, "w") as f:
            f.write(path)

        filepath = os.path.expanduser("~/.local/share/wallpapers/wallpaper.zsh")
        with open(filepath, "w") as f:
            f.write("export WALLPAPER=" + path)
        
        # Execute wallpaper script
        self.process = QProcess()
        self.process.finished.connect(lambda: self._on_wallpaper_process_finished(path))
        self.process.start("bash", ["-c", f"exec ~/.local/share/wallpapers/wallpaper.sh {path}"])

    def _on_wallpaper_process_finished(self, path):
        # Update the selected path only after processing is complete
        self._selected_path = path
        
        # Clear loading state when process finishes
        self._set_loading(False)
        
        # Emit signal to notify QML that selected property changed
        self.selectedChanged.emit()
        
        # Disconnect to avoid memory leaks
        self.process.finished.disconnect()

if __name__ == "__main__":
    app = QGuiApplication()
    engine = QQmlApplicationEngine()
    wallpaper_model = WallpaperModel()
    engine.rootContext().setContextProperty("WallpaperModel", wallpaper_model)
    path = os.path.expanduser("~/.config/quickshell/widgets/wallpaper/change-wallpaper.qml")
    engine.load(path)
    exit(app.exec())
