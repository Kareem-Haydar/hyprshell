import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Qt.labs.platform 1.0

Window {
  id: win
  visible: true
  width: 600
  height: 900
  title: qsTr("Wallpaper Changer")
  color: themeColors.roles?.background ?? "gray"

  property var themeColors: ({})

  function loadTheme() {
    var home = StandardPaths.standardLocations(StandardPaths.HomeLocation)[0];
    console.log("home: " + home);
    var themePath = home + "/.cache/wallpaper-theme.json";
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

  Component.onCompleted: {
    WallpaperModel?.refresh
    loadTheme()
  }

  ColumnLayout {
    anchors.fill: parent

    Rectangle {
      Layout.preferredHeight: 190
      Layout.fillWidth: true
      Layout.topMargin: 10
      Layout.bottomMargin: 10
      color: win.color
      z: 1
      
      Rectangle {
        width: 300
        height: 180
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: Qt.rgba(0.3, 0.3, 0.3, 1.0)
        border.width: 1
        radius: 4
        
        Image {
          id: img
          anchors.fill: parent
          anchors.margins: 5
          fillMode: Image.PreserveAspectCrop
          source: WallpaperModel?.selected
          opacity: WallpaperModel?.isLoading ? 0.5 : 1.0
          
          Behavior on opacity {
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
          }
        }
        
        // Loading overlay
        Rectangle {
          anchors.fill: parent
          anchors.margins: 5
          color: Qt.rgba(0, 0, 0, 0.3)
          radius: 2
          visible: WallpaperModel?.isLoading
          
          // Spinning loading indicator
          Rectangle {
            id: spinner
            width: 40
            height: 40
            anchors.centerIn: parent
            color: "transparent"
            border.width: 3
            border.color: Qt.rgba(1, 1, 1, 0.3)
            radius: 20
            
            Rectangle {
              width: 6
              height: 6
              radius: 3
              color: "white"
              anchors.horizontalCenter: parent.horizontalCenter
              anchors.top: parent.top
              anchors.topMargin: 2
            }
            
            RotationAnimation {
              target: spinner
              property: "rotation"
              from: 0
              to: 360
              duration: 1000
              loops: Animation.Infinite
              running: WallpaperModel?.isLoading
            }
          }
          
          // Loading text
          Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: spinner.bottom
            anchors.topMargin: 10
            text: "Applying wallpaper..."
            color: themeColors.roles?.onBackground ?? "white"
            font.pixelSize: 12
            font.bold: true
          }
          
          // Fade in animation for loading overlay
          opacity: WallpaperModel?.isLoading ? 1.0 : 0.0
          
          Behavior on opacity {
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
          }
        }
      }
    }
    
    ScrollView {
      Layout.fillWidth: true
      Layout.preferredHeight: win.height - 190
      
      GridView {
        id: gridView
        anchors.fill: parent
        cellWidth: 150
        cellHeight: 100
        model: WallpaperModel?.thumbnails
        
        delegate: Rectangle {
          width: 140
          height: 90
          border.width: 1
          color: themeColors.roles?.onBackground ?? "gray"
          radius: 4
          opacity: WallpaperModel?.isLoading ? 0.6 : 1.0
          
          Behavior on opacity {
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
          }
          
          Image {
            anchors.fill: parent
            anchors.margins: 5
            source: modelData
            fillMode: Image.PreserveAspectCrop
            smooth: true
            cache: true
            asynchronous: true
          }
          
          Rectangle {
            id: tooltip
            visible: false
            clip: true
            color: Qt.rgba(0.3, 0.3, 0.3, 0.9)
            width: parent.width * 0.75
            height: 20
            radius: 4
            x: 4
            opacity: 0
            
            Text {
              id: text
              anchors.left: parent.left
              anchors.leftMargin: 4
              anchors.verticalCenter: parent.verticalCenter
              text: {
                var fullPath = modelData
                var parts = fullPath.split("/")
                var fileName = parts[parts.length - 1].split(".")[0]
                return fileName
              }
              color: "white"
              font.pixelSize: 12
              wrapMode: Text.NoWrap
              elide: Text.ElideRight
            }
            
            Behavior on opacity {
              NumberAnimation { duration: 151; easing.type: Easing.OutCubic }
            }

            Behavior on y {
              NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }
          }
          
          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            enabled: !WallpaperModel?.isLoading  // Disable clicks during loading
            
            onClicked: {
              WallpaperModel?.set_wallpaper(WallpaperModel.wallpapers[index])
              loadTheme()
            }
            onEntered: {
              if (!WallpaperModel?.isLoading) {
                tooltip.visible = true
                tooltip.opacity = 1
                tooltip.y = 4
              }
            }
            onExited: {
              tooltip.opacity = 0
              tooltip.y = -5

              Qt.callLater(function() {
                if (tooltip.opacity == 0) {
                  tooltip.visible = false                  
                }               
              })
            }
          }
        }
      }
    }
  }
}
