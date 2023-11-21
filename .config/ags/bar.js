import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const Workspaces = (monitor) =>
  Widget.Box({
    className: "workspaces",
    connections: [
      [
        Hyprland.active.workspace,
        (self) => {
          // generate an array [1..9] then make buttons from the index
          const arr = Array.from({ length: 9 }, (_, i) => i + 1);
          self.children = arr.map((i) =>
            Widget.Button({
              onClicked: () =>
                execAsync(`hyprctl dispatch workspace ${i + monitor * 10}`),
              child: Widget.Label(""),
              className:
                Hyprland.active.workspace.id == i + monitor * 10
                  ? "focused"
                  : "",
            }),
          );
        },
      ],
    ],
  });

const ClientTitle = (monitor) =>
  Widget.Label({
    className: "client-title",
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

const SysTray = () =>
  Widget.Box({
    className: "systray",
    connections: [
      [
        SystemTray,
        (self) => {
          self.children = SystemTray.items.map((item) =>
            Widget.Button({
              child: Widget.Icon({ binds: [["icon", item, "icon"]] }),
              onPrimaryClick: (_, event) => item.activate(event),
              onSecondaryClick: (_, event) => item.openMenu(event),
              binds: [["tooltip-markup", item, "tooltip-markup"]],
            }),
          );
        },
      ],
    ],
  });

const Clock = () =>
  Widget.Label({
    className: "clock",
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
  Widget.Box({
    className: "battery",
    connections: [
      [
        Battery.available,
        (self) => {
          if (!Battery.available) return;
          self.children = [
            Widget.Icon({
              binds: [
                ["icon", Battery, "icon-name"],
                ["tooltip-markup", Battery, "percent", (p) => `Battery: ${p}%`],
              ],
            }),
          ];
        },
      ],
    ],
    // children: [
    //   Widget.Icon({
    //     binds: [
    //       ["icon", Battery, "icon-name"],
    //       ["tooltip-markup", Battery, "percent", (p) => `Battery: ${p}%`],
    //     ],
    //   }),
    // ],
  });

const Left = (monitor) =>
  Widget.Box({
    children: [Workspaces(monitor)],
  });

const Center = (monitor) =>
  Widget.Box({
    children: [ClientTitle(monitor)],
  });

const Right = (monitor) =>
  Widget.Box({
    hpack: "end",
    children: [SysTray(), BatteryIcon(), Clock()],
  });

export default ({ monitor } = {}) =>
  Widget.Window({
    name: `bar-${monitor}`,
    className: "bar",
    monitor,
    exclusive: true,
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
      startWidget: Left(monitor),
      centerWidget: Center(monitor),
      endWidget: Right(),
    }),
  });
