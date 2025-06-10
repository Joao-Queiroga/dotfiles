import { bind } from "astal";
import AstalBattery from "gi://AstalBattery";

export const Battery = () => {
  const bat = AstalBattery.get_default();
  return (
    <image
      visible={bind(bat, "is_present")}
      icon_name={bind(bat, "battery_icon_name")}
      tooltip_markup={bind(bat, "percentage").as(percent => {
        const formatTime = (seconds: number) => {
          const minutes = Math.floor(seconds / 60) % 60;
          const hours = Math.floor(seconds / 3600);
          return `${hours}:${minutes.toString().padStart(2, "0")}`;
        };

        const state = bat.get_state();
        const stateText =
          {
            [AstalBattery.State.FULLY_CHARGED]: "Full",
            [AstalBattery.State.CHARGING]: `Charging\n${formatTime(bat.get_time_to_full())} remaining`,
            [AstalBattery.State.DISCHARGING]: `Discharging\n${formatTime(bat.get_time_to_empty())} remaining`,
          }[state] || "";

        return `${Math.floor(percent * 100)}% ${stateText}`;
      })}
    />
  );
};
