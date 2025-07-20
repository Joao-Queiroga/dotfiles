import { Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { MicrophoneSlider, VolumeSlider } from "../../components/Volume";
import { BrightnessSlider } from "../../components/Brightness";

export const ControlMenu = () => (
  <popover hasArrow class="control-menu">
    <box orientation={Gtk.Orientation.VERTICAL}>
      <VolumeSlider />
      <MicrophoneSlider />
      <BrightnessSlider />
      <button halign={Gtk.Align.END} onClicked={() => app.get_window("powermenu")!.show()}>
        <image iconName="system-shutdown-symbolic" />
      </button>
    </box>
  </popover>
);
