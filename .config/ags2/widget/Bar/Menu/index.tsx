import { App, Gtk } from "astal/gtk4";
import { VolumeSlider } from "./Volume";
import { NetworkName } from "./Network";

export default function Menu() {
  return (
    <menubutton>
      <label label="X" />
      <popover has_arrow cssClasses={["control-menu"]}>
        <box vertical>
          <VolumeSlider />
          <button halign={Gtk.Align.END} onClicked={() => App.get_window("powermenu")!.show()}>
            <image iconName="system-shutdown-symbolic" />
          </button>
          <NetworkName />
        </box>
      </popover>
    </menubutton>
  );
}
