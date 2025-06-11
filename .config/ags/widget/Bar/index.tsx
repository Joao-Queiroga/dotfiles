import app from "ags/gtk4/app";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { Poll } from "ags/state";
import GLib from "gi://GLib";
import { Client, Workspaces } from "./Hyprland";
import { Tray } from "./Tray";
import { Battery } from "./Battery";
import { Volume } from "./Volume";

const time = new Poll(GLib.DateTime.new_now_local(), 1000, () => GLib.DateTime.new_now_local());

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name="bar"
      class="bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssName="centerbox">
        <box _type="start">
          <Workspaces />
          <Client />
        </box>
        <menubutton _type="center" hexpand halign={Gtk.Align.CENTER}>
          <label class="time" label={time(t => t.format("  %a %d/%m/%Y %H:%M")!)} />
          <popover>
            <Gtk.Calendar />
          </popover>
        </menubutton>
        <box _type="end">
          <Tray />
          <Volume />
          <Battery />
          <button $clicked={() => app.get_window("powermenu")!.show()}>
            <image iconName="system-shutdown-symbolic" />
          </button>
        </box>
      </centerbox>
    </window>
  );
}
