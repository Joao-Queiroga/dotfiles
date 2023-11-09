import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
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
              child: Widget.Label(`${i}`),
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

const Clock = () =>
  Widget.Label({
    className: "clock",
    connections: [
      [
        1000,
        (self) =>
          execAsync(["date", "+%a %d/%m/%Y %H:%M"])
            .then((date) => (self.label = date))
            .catch(console.error),
      ],
    ],
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
    children: [Clock()],
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
