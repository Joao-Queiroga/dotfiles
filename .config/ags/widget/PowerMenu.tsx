import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { exec } from "ags/process";
import GLib from "gi://GLib";

const systemd = GLib.file_test("/run/systemd/system", GLib.FileTest.EXISTS);

const hide = () => app.get_window("powermenu")!.hide();

const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

export default function Powermenu() {
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
        onKeyPressed={({ widget }, keyval) => {
          if (keyval === Gdk.KEY_Escape) {
            widget.hide();
          }
        }}
      />
      <box valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} hexpand vexpand>
        <button onClicked={() => exec([systemd ? "systemctl" : "loginctl", "poweroff"])}>
          <box orientation={Gtk.Orientation.VERTICAL}>
            <image iconName="system-shutdown-symbolic" />
            <label label="PowerOff" />
          </box>
        </button>
        <button onClicked={() => exec([systemd ? "systemctl" : "loginctl", "reboot"])}>
          <box orientation={Gtk.Orientation.VERTICAL}>
            <image iconName="system-reboot-symbolic" />
            <label label="Reboot" />
          </box>
        </button>
        <button onClicked={() => exec([systemd ? "systemctl" : "loginctl", "suspend"]) && hide()}>
          <box orientation={Gtk.Orientation.VERTICAL}>
            <image iconName="system-suspend-symbolic" />
            <label label="Suspend" />
          </box>
        </button>
        <button onClicked={() => exec([systemd ? "systemctl" : "loginctl", "hibernate"]) && hide()}>
          <box orientation={Gtk.Orientation.VERTICAL}>
            <image iconName="system-hibernate-symbolic" />
            <label label="Hibernate" />
          </box>
        </button>
      </box>
    </window>
  );
}
