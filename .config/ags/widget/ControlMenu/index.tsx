import { Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { MicrophoneSlider, VolumeSlider } from "../../components/Volume";
import { BrightnessSlider } from "../../components/Brightness";
import { Buttons } from "../../components/PowerProfiles";

export const ControlMenu = () => (
  <popover hasArrow class="control-menu">
    <box orientation={Gtk.Orientation.VERTICAL}>
      <VolumeSlider />
      <MicrophoneSlider />
      <BrightnessSlider />
      <centerbox>
        <box $type="start" halign={Gtk.Align.START}>
          <Buttons />
        </box>
        <button $type="end" onClicked={() => app.get_window("powermenu")!.show()}>
          <image iconName="system-shutdown-symbolic" />
        </button>
      </centerbox>
    </box>
  </popover>
);
