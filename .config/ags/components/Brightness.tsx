import { createBinding } from "ags";
import Backlight from "../lib/services/backlight";

const screen = Backlight.get_default();

export const BrightnessIcon = () => <image icon_name="display-brightness" />;

export const BrightnessSlider = () => (
  <box>
    <BrightnessIcon />
    <slider
      hexpand
      onChangeValue={({ value }) => {
        screen.brightness = value;
      }}
      value={createBinding(screen, "brightness")}
      digits={2}
      min={0.1}
    />
  </box>
);
