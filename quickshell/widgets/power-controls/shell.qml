import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 
import Quickshell 
import Quickshell.Widgets

Scope {
  id: control

  property bool showWidget: false

  PanelWindow {
    id: bg

    color: 'transparent'
    implicitWidth: screen.width
    implicitHeight: screen.height

    Rectangle {
      anchors.fill: parent
      color: Qt.rgba(0.2, 0.2, 0.2, 0.6)
    }

    Rectangle {
      implicitWidth: bg.width * 0.5
      implicitHeight: bg.height * 0.5
      anchors.centerIn: parent
      color: Qt.rgba(0.9, 0.9, 0.9, 1)
      radius: 8

      ColumnLayout {
        anchors.fill: parent

        RowLayout {
          id: topLayer

          Button {
            id: sleepButton

            Layout.fillWidth: true;
            Layout.fillHeight: true;
            Layout.leftMargin: 10
            Layout.topMargin: 10
            Layout.bottomMargin: 10

            icon.source: 'icons/sleep.png'
            icon.width: 256
            icon.height: 256
            onClicked: {
              Qt.openUrlExternally("file://./sleep.sh");
              console.log('sleep')
            }

            onHoveredChanged: {
              if (hovered) {
                background.color = "red";
                sleepText.y = height * 0.9
                sleepText.opacity = 1
              } else {
                background.color = "gray";
                sleepText.y = height * 0.95
                sleepText.opacity = 0
              }
            }
            
            Text {
              id: sleepText

              text: "Sleep"

              x: (parent.width / 2) - (sleepText.width / 2)
              y: parent.height * 0.95

              opacity: 0

              font.pointSize: 16

              Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
              }

              Behavior on y {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
              }
            }

            background: Rectangle {
              radius: 8

              Behavior on color {
                ColorAnimation { duration: 150; easing.type: Easing.Linear }
              }
            }
          }
          Button {
            id: lockButton

            Layout.fillWidth: true;
            Layout.fillHeight: true;
            Layout.margins: 10

            icon.source: 'icons/lock.png'
            icon.width: 256
            icon.height: 256
            onClicked: {
              console.log('lock')
            }

            onHoveredChanged: {
              if (hovered) {
                background.color = "red";
                lockText.y = height * 0.9
                lockText.opacity = 1
              } else {
                background.color = "gray";
                lockText.y = height * 0.95
                lockText.opacity = 0
              }
            }
            
            Text {
              id: lockText

              text: "Lock"

              x: (parent.width / 2) - (lockText.width / 2)
              y: parent.height * 0.95

              opacity: 0

              font.pointSize: 16

              Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
              }

              Behavior on y {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
              }
            }

            background: Rectangle {
              radius: 8

              Behavior on color {
                ColorAnimation { duration: 150; easing.type: Easing.Linear }
              }
            }
          }
        }

        RowLayout {
          id: bottomLayer

          Button {
            id: shutDownButton

            Layout.fillWidth: true;
            Layout.fillHeight: true;
            Layout.leftMargin: 10
            Layout.bottomMargin: 10

            icon.source: 'icons/shutdown.png'
            icon.width: 256
            icon.height: 256
            onClicked: {
              console.log('shut down')
            }

            onHoveredChanged: {
              if (hovered) {
                background.color = "red";
                shutDownText.y = height * 0.9
                shutDownText.opacity = 1
              } else {
                background.color = "gray";
                shutDownText.y = height * 0.95
                shutDownText.opacity = 0
              }
            }
            
            Text {
              id: shutDownText

              text: "Shut Down"

              x: (parent.width / 2) - (shutDownText.width / 2)
              y: parent.height * 0.95

              opacity: 0

              font.pointSize: 16

              Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
              }

              Behavior on y {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
              }
            }

            background: Rectangle {
              radius: 8

              Behavior on color {
                ColorAnimation { duration: 150; easing.type: Easing.Linear }
              }
            }
          }
          Button {
            id: logOutButton

            Layout.fillWidth: true;
            Layout.fillHeight: true;
            Layout.bottomMargin: 10
            Layout.rightMargin: 10
            Layout.leftMargin: 10

            icon.source: 'icons/logout.png'
            icon.width: 256
            icon.height: 256
            onClicked: {
              console.log('log out')
            }

            onHoveredChanged: {
              if (hovered) {
                background.color = "red";
                logOutText.y = height * 0.9
                logOutText.opacity = 1
              } else {
                background.color = "gray";
                logOutText.y = height * 0.95
                logOutText.opacity = 0
              }
            }
            
            Text {
              id: logOutText

              text: "Log Out"

              x: (parent.width / 2) - (logOutText.width / 2)
              y: parent.height * 0.95

              opacity: 0

              font.pointSize: 16

              Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
              }

              Behavior on y {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
              }
            }

            background: Rectangle {
              radius: 8

              Behavior on color {
                ColorAnimation { duration: 150; easing.type: Easing.Linear }
              }
            }
          }
        }
      }
    }
  }
}
