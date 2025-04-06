import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { FocusedClient, Workspaces } from "./Hyprland";
import { Time } from "../../lib/variables";
import { Systray } from "./Systray";
import { Volume } from "./Volume";
import { Battery } from "./Battery";

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      cssClasses={["bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox>
        <box>
          <Workspaces />
        </box>
        <box>
          <FocusedClient />
        </box>
        <box>
          <Systray />
          <Volume />
          <Battery />
          <menubutton>
            <Time format="  %a %d/%m/%Y %H:%M" />
            <popover>
              <Gtk.Calendar />
            </popover>
          </menubutton>
        </box>
      </centerbox>
    </window>
  );
}
