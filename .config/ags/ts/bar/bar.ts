import Widget from "resource:///com/github/Aylur/ags/widget.js";
import SysTray from "./buttons/systray.ts";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Volume from "./buttons/volume.ts";
import BatteryIcon from "./buttons/battery";
import Workspaces from "./buttons/workspaces.ts";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { truncateString } from "ts/utils";

const ClientTitle = (monitor: number) =>
  Widget.Label({
    class_name: "client-title",
    setup: (self) =>
      self.hook(Hyprland.active, () => {
        const mon = Hyprland.getMonitor(monitor);
        self.label =
          truncateString(
            Hyprland.getWorkspace(mon?.activeWorkspace.id || 0)
              ?.lastwindowtitle,
            25,
          ) || "";
      }),
  });

const Clock = () =>
  Widget.Label({
    class_name: "clock",
    setup: (self) =>
      self.poll(1000, (self) =>
        execAsync(["date", "+%a %d/%m/%Y %H:%M"]).then(
          (date) => (self.label = `  ${date}`),
        ),
      ),
  });

const Left = (monitor: number) =>
  Widget.Box({
    children: [Workspaces(monitor)],
  });

const Center = (monitor: number) =>
  Widget.Box({
    children: [ClientTitle(monitor)],
  });

const Right = () =>
  Widget.Box({
    hpack: "end",
    children: [SysTray(), Volume(), BatteryIcon(), Clock()],
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
