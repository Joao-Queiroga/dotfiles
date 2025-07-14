import { Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { MicrophoneSlider, VolumeSlider } from "../../components/Volume";

export default function () {
  return (
    <popover hasArrow class="control-menu">
      <box orientation={Gtk.Orientation.VERTICAL}>
        <VolumeSlider />
        <MicrophoneSlider />
        <button halign={Gtk.Align.END} onClicked={() => app.get_window("powermenu")!.show()}>
          <image iconName="system-shutdown-symbolic" />
        </button>
      </box>
    </popover>
  );
}
