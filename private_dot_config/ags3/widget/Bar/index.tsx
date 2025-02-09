import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import Workspaces from "./Workspaces";
import SysTray from "./Systray";
import Battery from "./Battery";
import { Time } from "../../lib/variables";
import Volume from "./Volume";

export default function Bar(monitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
  return <window
    className="bar"
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
    application={App}>
    <centerbox>
      <box hexpand halign={Gtk.Align.START} >
        <Workspaces />
      </box>
      <box></box>
      <box hexpand halign={Gtk.Align.END} >
        <SysTray />
        <Volume />
        <Battery />
        <Time format="  %a %d/%m/%Y %H:%M" />
      </box>
    </centerbox>
  </window>
}
