import { createBinding, For, onCleanup } from "ags";
import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { createPoll } from "ags/time";
import GLib from "gi://GLib";
import { BatteryIcon } from "../../components/Battery";
import { Client, Workspaces } from "../../components/Hyprland";
import { Tray } from "../../components/Tray";
import { VolumeIcon } from "../../components/Volume";
import { ControlMenu } from "../ControlMenu";
import { NiriClient, NiriWorkspaces } from "../../components/Niri";

const time = createPoll(GLib.DateTime.new_now_local(), 1000, () => GLib.DateTime.new_now_local());

export default function Bar({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
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
      $={self => onCleanup(() => self.destroy())}
    >
      <centerbox cssName="centerbox">
        <box $type="start">
          {GLib.getenv("XDG_SESSION_DESKTOP") === "Hyprland" && (
            <>
              <Workspaces gdkmonitor={gdkmonitor} />
              <Client gdkmonitor={gdkmonitor} />
            </>
          )}
          {GLib.getenv("XDG_SESSION_DESKTOP") === "niri" && (
            <>
              <NiriWorkspaces gdkmonitor={gdkmonitor} />
              <NiriClient gdkmonitor={gdkmonitor} />
            </>
          )}
        </box>
        <menubutton $type="center" hexpand halign={Gtk.Align.CENTER}>
          <label class="time" label={time(t => t.format("  %a %d/%m/%Y %H:%M")!)} />
          <popover>
            <Gtk.Calendar />
          </popover>
        </menubutton>
        <box $type="end">
          <Tray />
          <VolumeIcon />
          <BatteryIcon />
          <menubutton>
            <ControlMenu />
          </menubutton>
        </box>
      </centerbox>
    </window>
  );
}
