import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root

  property bool showWidget: false
  property var themeColors: ({})

  function loadTheme() {
    var home = Quickshell.env("HOME");
    console.log("home: " + home);
    var themePath = "file://" + home + "/.cache/wallpaper-theme.json";
    console.log("loading theme file " + themePath);
    var xhr = new XMLHttpRequest();
    xhr.open("GET", themePath, true);
    xhr.onreadystatechange = function() {
      if (xhr.readyState === XMLHttpRequest.DONE) {
          if (xhr.status === 200) {
            try {
              console.log(xhr.responseText);
              themeColors = JSON.parse(xhr.responseText);
              console.log("Theme loaded successfully");
            } catch (e) {
              console.error("Error parsing JSON:", e);
            }
        } else {
          console.error("Failed to load theme file:", xhr.status);
        }
      }
    };

    xhr.send();
  }

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio

    function onVolumeChanged() {
      root.loadTheme()
      root.showWidget = true
      Pipewire.defaultAudioSink.audio.muted = false
      hideTimer.restart()
    }

    function onMutedChanged() {
      root.loadTheme()
      root.showWidget = true
      hideTimer.restart()
    }
  }

  Timer {
    id: hideTimer
    interval: 750
    onTriggered: root.showWidget = false
  }

  LazyLoader {
    active: root.showWidget

    Component.onCompleted: loadTheme()

    PanelWindow {
      anchors.bottom: true
      margins.bottom: screen.height / 5
      exclusiveZone: 0

      implicitWidth: 400
      implicitHeight: 50
      color: "transparent"


      mask: Region {}

      Rectangle {
        id: osdBackground

        width: 400
        height: 50

        radius: 20

        color: (root.themeColors.roles?.background ?? "#000000")

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 15
          }

          MultiEffect {
            Layout.preferredWidth: 30
            Layout.preferredHeight: 30

            source: volIcon
            colorization: 1
            colorizationColor: themeColors.roles?.onBackground ?? "#000000"

            IconImage {
              id: volIcon
              anchors.fill: parent

              source: {
                let vol = Pipewire.defaultAudioSink?.audio.volume ?? 0

                if (vol == 0 || Pipewire.defaultAudioSink?.audio.muted) {
                  return Quickshell.iconPath("audio-volume-muted")
                } else if (vol <= 0.33) {
                  return Quickshell.iconPath("audio-volume-low")
                } else if (vol <= 0.66) {
                  return Quickshell.iconPath("audio-volume-medium")
                } else {
                  return Quickshell.iconPath("audio-volume-high")
                }
              }
            }
          }

          Rectangle {
            Layout.fillWidth: true

            implicitHeight: 10
            radius: 20
            color: themeColors.palettes?.primary[5] ?? "#50ffffff"

            Rectangle {
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }

              implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
              radius: parent.radius
              color: themeColors.roles?.primary ?? "#000000"

              Behavior on implicitWidth {
                NumberAnimation {
                  duration: 100
                  easing.type: Easing.OutQuad
                }
              }
            }
          }

          Text {
            text: ((Pipewire.defaultAudioSink?.audio.volume ?? 0).toFixed(2) * 100).toFixed(0) + "%"
            color: themeColors.roles?.onBackground ?? "#000000"
          }
        }
      }
    }
  }
}

