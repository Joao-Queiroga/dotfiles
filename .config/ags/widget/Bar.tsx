import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { GLib, Variable, bind } from "astal"
import Tray from "gi://AstalTray"
import Battery from "gi://AstalBattery";
import Hyprland from "gi://AstalHyprland";


function SysTray() {
  const tray = Tray.get_default();

  return <box>
    {bind(tray, "items").as(items => items.map(item => {
      if (item.iconThemePath)
        App.add_icons(item.iconThemePath)

      const menu = item.create_menu()

      return <button
        tooltipMarkup={bind(item, "tooltipMarkup")}
        onDestroy={() => menu?.destroy()}
        onClickRelease={self => {
          menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
        }}>
        <icon icon={bind(item, "iconName")} />
      </button>
    }))}
  </box>
}

function Workspaces() {
  const hypr = Hyprland.get_default()

  return <box className="Workspaces">
    {Array.from({ length: 9 }, (_, i) => i + 1).map(i => {
      return <button
        className={bind(hypr, "clients").as(_ => {
          const classes: string[] = []
          if (hypr.get_focused_workspace().get_id() == i) {
            classes.push("active")
          }
          if ((hypr.get_workspace(i)?.get_clients().length || 0) > 0) {
            classes.push("occupied")
          }
          return classes.join(" ")
        })}
        onClicked={() => hypr.dispatch("workspace", i.toString())}>
        <label className="indicator" halign={Gtk.Align.CENTER} label={i.toString()} />
      </button>
    })}
  </box >
}

function BatteryLevel() {
  const bat = Battery.get_default()
  return <icon className="battery"
    visible={bind(bat, "isPresent")}
    icon={bind(bat, "batteryIconName")}
    tooltipMarkup={bind(bat, "percentage").as(percent => {
      const formatTime = (seconds: number) => {
        const minutes = Math.floor(seconds / 60);
        const hours = Math.floor(minutes / 60);
        return `${hours}:${(minutes % 60).toString().padStart(2, "0")}`;
      };

      const state = bat.get_state()
      let text = `${bat.get_percentage()}% `;
      switch (state) {
        case Battery.State.FULLY_CHARGED:
          text += "Full"
          break;
        case Battery.State.CHARGING:
          text += `Charging\n${formatTime(bat.get_time_to_full())} remaining`
          break;
        case Battery.State.DISCHARGING:
          text += `Discharging\n${formatTime(bat.get_time_to_empty())} remaining`
          break;
        default:
          break;
      }
      return text
    })}
  />
}

function Time({ format = "  %a %d/%m/%Y %H:%M" }) {
  const time = Variable("").poll(1000, () =>
    GLib.DateTime.new_now_local().format(format)!);

  return <label className="Time"
    onDestroy={() => time.drop()} label={time()} />
}

export default function Bar(monitor: Gdk.Monitor) {
  return <window
    className="Bar"
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP
      | Astal.WindowAnchor.LEFT
      | Astal.WindowAnchor.RIGHT}
    application={App}>
    <centerbox>
      <box hexpand halign={Gtk.Align.START} >
        <Workspaces />
      </box>
      <box></box>
      <box hexpand halign={Gtk.Align.END} >
        <SysTray />
        <BatteryLevel />
        <Time />
      </box>
    </centerbox>
  </window>
}
