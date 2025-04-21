import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { FocusedClient, Workspaces } from "./Hyprland";
import { Time } from "../../lib/variables";
import { Systray } from "./Systray";
import { Volume } from "./Volume";
import { Battery } from "./Battery";
import { exec, GLib } from "astal";

const systemd = GLib.find_program_in_path("systemctl") !== null;

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
          <FocusedClient />
        </box>
        <box>
          <menubutton>
            <Time format="  %a %d/%m/%Y %H:%M" />
            <popover>
              <Gtk.Calendar />
            </popover>
          </menubutton>
        </box>
        <box>
          <Systray />
          <Volume />
          <Battery />
          <menubutton>
            <image iconName="system-shutdown-symbolic" />
            <popover>
              <box>
                <button onClicked={() => exec(systemd ? "poweroff" : ["loginctl", "poweroff"])}>
                  <image iconName="system-shutdown-symbolic" />
                </button>
                <button onClicked={() => exec(systemd ? "reboot" : ["loginctl", "reboot"])}>
                  <image iconName="system-reboot-symbolic" />
                </button>
                <button onClicked={() => exec([systemd ? "systemctl" : "loginctl", "suspend"])}>
                  <image iconName="system-suspend-symbolic" />
                </button>
                <button onClicked={() => exec([systemd ? "systemctl" : "loginctl", "hibernate"])}>
                  <image iconName="system-hibernate-symbolic" />
                </button>
              </box>
            </popover>
          </menubutton>
        </box>
      </centerbox>
    </window>
  );
}
