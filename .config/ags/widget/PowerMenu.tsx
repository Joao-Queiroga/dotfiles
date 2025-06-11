import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { exec } from "ags/process";
import GLib from "gi://GLib";

const systemd = GLib.find_program_in_path("systemctl") !== null;

const hide = () => app.get_window("powermenu")!.hide();

export default function Powermenu() {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
  return (
    <window
      name="powermenu"
      anchor={TOP | LEFT | RIGHT | BOTTOM}
      application={app}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.EXCLUSIVE}
      visible={false}
      layer={Astal.Layer.OVERLAY}
    >
      <Gtk.EventControllerKey
        $keyPressed={({ widget }, keyval) => {
          if (keyval === Gdk.KEY_Escape) {
            widget.hide();
          }
        }}
      />
      <box valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} hexpand vexpand>
        <button $clicked={() => exec(systemd ? "poweroff" : ["loginctl", "poweroff"])}>
          <box orientation={Gtk.Orientation.VERTICAL}>
            <image iconName="system-shutdown-symbolic" />
            <label label="PowerOff" />
          </box>
        </button>
        <button $clicked={() => exec(systemd ? "reboot" : ["loginctl", "reboot"])}>
          <box orientation={Gtk.Orientation.VERTICAL}>
            <image iconName="system-reboot-symbolic" />
            <label label="Reboot" />
          </box>
        </button>
        <button $clicked={() => exec([systemd ? "systemctl" : "loginctl", "suspend"]) && hide()}>
          <box orientation={Gtk.Orientation.VERTICAL}>
            <image iconName="system-suspend-symbolic" />
            <label label="Suspend" />
          </box>
        </button>
        <button $clicked={() => exec([systemd ? "systemctl" : "loginctl", "hibernate"]) && hide()}>
          <box orientation={Gtk.Orientation.VERTICAL}>
            <image iconName="system-hibernate-symbolic" />
            <label label="Hibernate" />
          </box>
        </button>
      </box>
    </window>
  );
}
