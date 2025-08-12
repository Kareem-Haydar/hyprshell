import QtQuick
import Quickshell
import Quickshell.Widgets

Scope {
  id: appSwitcherRoot

  Key {
    sequence: "Alt+Tab"
    onActivated: {
      console.log("Alt+Tab")
    }
  }
}
