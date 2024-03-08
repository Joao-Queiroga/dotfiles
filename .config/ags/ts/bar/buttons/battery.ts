const battery = await Service.import("battery");

enum BatteryState {
  FULL,
  CHARGING,
  DISCHARGING,
}

const makeText = (state: BatteryState) => {
  let text = `${battery.percent}% `;
  let seconds = battery.time_remaining;
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
    visible: battery.bind("available"),
    icon: battery.bind("icon_name"),
  }).hook(battery, (self) => {
    let state: BatteryState;
    switch (true) {
      case battery.charged:
        state = BatteryState.FULL;
        break;
      case battery.charging:
        state = BatteryState.CHARGING;
        break;
      default:
        state = BatteryState.DISCHARGING;
    }
    self.tooltip_text = makeText(state);
  });

export default BatteryIcon;
