import Widget from "resource:///com/github/Aylur/ags/widget.js";
import SysTray from "./buttons/systray.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Workspaces from "./buttons/workspaces.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const ClientTitle = (monitor) =>
  Widget.Label({
    class_name: "client-title",
    connections: [
      [
        Hyprland.active,
        (self) => {
          let mon = Hyprland.getMonitor(monitor);
          self.label = mon.focused
            ? Hyprland.active.client.title
            : Hyprland.getWorkspace(mon.activeWorkspace.id).lastwindowtitle;
        },
      ],
    ],
  });

const Clock = () =>
  Widget.Label({
    class_name: "clock",
    connections: [
      [
        1000,
        (self) =>
          execAsync(["date", "+%a %d/%m/%Y %H:%M"])
            .then((date) => (self.label = `  ${date}`))
            .catch(console.error),
      ],
    ],
  });

const BatteryIcon = () =>
  Widget.Icon({
    class_name: "battery",
    visible: Battery.bind("available"),
    icon: Battery.bind("icon_name"),
  });

const Left = (monitor) =>
  Widget.Box({
    children: [Workspaces(monitor)],
  });

const Center = (monitor) =>
  Widget.Box({
    children: [ClientTitle(monitor)],
  });

const Right = () =>
  Widget.Box({
    hpack: "end",
    children: [SysTray(), BatteryIcon(), Clock()],
  });

export default (monitor = 0) =>
  Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar",
    monitor,
    exclusivity: "exclusive",
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
      start_widget: Left(monitor),
      center_widget: Center(monitor),
      end_widget: Right(),
    }),
  });
