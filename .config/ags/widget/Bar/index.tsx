import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { createPoll } from "ags/time";
import GLib from "gi://GLib";
import { Battery } from "./Battery";
import { Client, Workspaces } from "./Hyprland";
import { Tray } from "./Tray";
import { Volume } from "./Volume";
import { createBinding, For } from "ags";

const time = createPoll(GLib.DateTime.new_now_local(), 1000, () => GLib.DateTime.new_now_local());

export default function Bar() {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <For each={createBinding(app, "monitors")} cleanup={bar => (bar as Gtk.Window).destroy()}>
      {(monitor: Gdk.Monitor) => (
        <window
          visible
          name="bar"
          class="bar"
          gdkmonitor={monitor}
          exclusivity={Astal.Exclusivity.EXCLUSIVE}
          anchor={TOP | LEFT | RIGHT}
          application={app}
        >
          <centerbox cssName="centerbox">
            <box $type="start">
              <Workspaces />
              <Client />
            </box>
            <menubutton $type="center" hexpand halign={Gtk.Align.CENTER}>
              <label class="time" label={time(t => t.format("  %a %d/%m/%Y %H:%M")!)} />
              <popover>
                <Gtk.Calendar />
              </popover>
            </menubutton>
            <box $type="end">
              <Tray />
              <Volume />
              <Battery />
              <button onClicked={() => app.get_window("powermenu")!.show()}>
                <image iconName="system-shutdown-symbolic" />
              </button>
            </box>
          </centerbox>
        </window>
      )}
    </For>
  );
}
