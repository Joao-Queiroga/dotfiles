import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";

enum BatteryState {
  FULL,
  CHARGING,
  DISCHARGING,
}

const makeText = (state: BatteryState) => {
  let text = `${Battery.percent}% `;
  let seconds = Battery.time_remaining;
  let minutes = Math.floor(seconds / 60);
  let hours = Math.floor(minutes / 60);
  minutes %= 60;
  switch (state) {
    case BatteryState.FULL:
      text += "Full";
      break;
    case BatteryState.CHARGING:
      text += `Charging\n${hours}:${minutes.toString().padStart(2, "0")} remaining`;
      break;
    case BatteryState.DISCHARGING:
      text += `Discharging\n${hours}:${minutes.toString().padStart(2, "0")} remaining`;
      break;
  }
  return text;
};

const BatteryIcon = () =>
  Widget.Icon({
    class_names: ["battery", "icon"],
    visible: Battery.bind("available"),
    icon: Battery.bind("icon_name"),
  }).hook(Battery, (self) => {
    let state: BatteryState;
    switch (true) {
      case Battery.charged:
        state = BatteryState.FULL;
        break;
      case Battery.charging:
        state = BatteryState.CHARGING;
        break;
      default:
        state = BatteryState.DISCHARGING;
    }
    self.tooltip_text = makeText(state);
  });

export default BatteryIcon;
