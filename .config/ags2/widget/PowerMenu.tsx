import { exec, GLib } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";

const systemd = GLib.find_program_in_path("systemctl") !== null;

const hide = () => App.get_window("powermenu")!.hide();

export default function PowerMenu() {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
  return (
    <window
      name="powermenu"
      anchor={TOP | LEFT | RIGHT | BOTTOM}
      application={App}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.EXCLUSIVE}
      onKeyPressed={(_, keyval) => {
        keyval == Gdk.KEY_Escape && hide();
      }}
      layer={Astal.Layer.OVERLAY}
    >
      <box valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} hexpand vexpand>
        <button onClicked={() => exec(systemd ? "poweroff" : ["loginctl", "poweroff"])}>
          <box vertical>
            <image iconName="system-shutdown-symbolic" />
            <label label="PowerOff" />
          </box>
        </button>
        <button onClicked={() => exec(systemd ? "reboot" : ["loginctl", "reboot"])}>
          <box vertical>
            <image iconName="system-reboot-symbolic" />
            <label label="Reboot" />
          </box>
        </button>
        <button onClicked={() => exec([systemd ? "systemctl" : "loginctl", "suspend"])}>
          <box vertical>
            <image iconName="system-suspend-symbolic" />
            <label label="Suspend" />
          </box>
        </button>
        <button onClicked={() => exec([systemd ? "systemctl" : "loginctl", "hibernate"])}>
          <box vertical>
            <image iconName="system-hibernate-symbolic" />
            <label label="Hibernate" />
          </box>
        </button>
      </box>
    </window>
  );
}
