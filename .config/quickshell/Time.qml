pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  property string time: {
    Qt.formatDateTime(clock.date, "  ddd d/MM/yyyy hh:mm");
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
