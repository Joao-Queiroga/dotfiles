pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property string time: {
    Qt.locale().toString(clock.date, "  ddd d/MM/yyyy hh:mm");
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
