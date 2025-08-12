import QtQuick
import Quickshell

Scope {
  id: shellRoot

  Loader { source: Quickshell.env("HOME") + "/.config/quickshell/widgets/volume-osd/shell.qml" }
}
