const battery = await Service.import("battery");

enum BatteryState {
  FULL,
  CHARGING,
  DISCHARGING,
}

const formatTime = (seconds: number) => {
  const minutes = Math.floor(seconds / 60);
  const hours = Math.floor(minutes / 60);
  return `${hours}:${(minutes % 60).toString().padStart(2, "0")}`;
};

const batteryStateTexts: Record<BatteryState, (seconds: number) => string> = {
  [BatteryState.FULL]: () => "Full",
  [BatteryState.CHARGING]: (seconds) =>
    `Charging\n${formatTime(seconds)} remaining`,
  [BatteryState.DISCHARGING]: (seconds) =>
    `Discharging\n${formatTime(seconds)} remaining`,
};

const makeText = (state: BatteryState) => {
  return `${battery.percent}% ${batteryStateTexts[state](battery.time_remaining)}`;
};

const BatteryIcon = () =>
  Widget.Icon({
    class_name: "battery",
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
