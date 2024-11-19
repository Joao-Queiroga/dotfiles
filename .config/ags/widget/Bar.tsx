import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { GLib, Variable, bind } from "astal"
import Tray from "gi://AstalTray"
import Battery from "gi://AstalBattery";
import Hyprland from "gi://AstalHyprland";
import Wp from "gi://AstalWp";


function SysTray() {
  const tray = Tray.get_default();

  return <box className="systray">
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

  return <box className="workspaces">
    {Array.from({ length: 9 }, (_, i) => i + 1).map(i => {
      return <button
        onClicked={() => hypr.dispatch("workspace", i.toString())}
        setup={self => {
          self.hook(hypr, "event", () => {
            self.toggleClassName("occupied", (hypr.get_workspace(i)?.get_clients().length || 0) > 0)
            self.toggleClassName("active", hypr.get_focused_workspace().get_id() === i)
          })
        }}
      >
        <label className="indicator" halign={Gtk.Align.CENTER} label={i.toString()} />
      </button>
    })}
  </box >
}

function Volume() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!
  return <button className="volume"
    tooltipMarkup={bind(speaker, "volume").as(vol => `${Math.floor(vol * 100)}%`)}
    onClick={() => speaker.set_mute(!speaker.get_mute)} >
    <icon icon={bind(speaker, "volumeIcon")} />
  </button>
}

function BatteryLevel() {
  const bat = Battery.get_default()
  return <icon className="battery"
    visible={bind(bat, "isPresent")}
    icon={bind(bat, "batteryIconName")}
    tooltipMarkup={bind(bat, "percentage").as(percent => {
      const formatTime = (seconds: number) => {
        const minutes = Math.floor(seconds / 60) % 60;
        const hours = Math.floor(seconds / 3600);
        return `${hours}:${minutes.toString().padStart(2, "0")}`;
      };

      const state = bat.get_state();
      const stateText = {
        [Battery.State.FULLY_CHARGED]: "Full",
        [Battery.State.CHARGING]: `Charging\n${formatTime(bat.get_time_to_full())} remaining`,
        [Battery.State.DISCHARGING]: `Discharging\n${formatTime(bat.get_time_to_empty())} remaining`,
      }[state] || "";

      return `${Math.floor(percent * 100)}% ${stateText}`;
    })}
  />
}

function Time({ format = "  %a %d/%m/%Y %H:%M" }) {
  const time = Variable("").poll(1000, () =>
    GLib.DateTime.new_now_local().format(format)!);

  return <label className="time"
    onDestroy={() => time.drop()} label={time()} />
}

export default function Bar(monitor: Gdk.Monitor) {
  return <window
    className="bar"
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
        <Volume />
        <BatteryLevel />
        <Time />
      </box>
    </centerbox>
  </window>
}
