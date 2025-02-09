import { bind } from "astal"
import Battery from "gi://AstalBattery";

export default function BatteryLevel() {
  const bat = Battery.get_default()
  return <icon className="battery"
    visible={bind(bat, "isPresent")}
    icon={bind(bat, "batteryIconName")}
    tooltipMarkup={bind(bat, "percentage").as(percent => {
      const formatTime = (seconds: number) => {
        const minutes = Math.floor(seconds / 60) % 60;
        const hours = Math.floor(seconds / 3600);
        return `${hours}:${minutes.toString().padStart(2, "0")}`;
      };

      const state = bat.get_state();
      const stateText = {
        [Battery.State.FULLY_CHARGED]: "Full",
        [Battery.State.CHARGING]: `Charging\n${formatTime(bat.get_time_to_full())} remaining`,
        [Battery.State.DISCHARGING]: `Discharging\n${formatTime(bat.get_time_to_empty())} remaining`,
      }[state] || "";

      return `${Math.floor(percent * 100)}% ${stateText}`;
    })}
  />
}
