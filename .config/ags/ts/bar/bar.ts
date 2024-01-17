import Widget from "resource:///com/github/Aylur/ags/widget.js";
import SysTray from "./buttons/systray.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Volume from "./buttons/volume.js";
import Workspaces from "./buttons/workspaces.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const ClientTitle = (/** @type {number} */ monitor) =>
  Widget.Label({
    class_name: "client-title",
    setup: (self) =>
      self.hook(Hyprland.active, () => {
        const mon = Hyprland.getMonitor(monitor);
        self.label =
          Hyprland.getWorkspace(mon?.activeWorkspace.id || 0)
            ?.lastwindowtitle || "";
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

const BatteryIcon = () =>
  Widget.Icon({
    class_name: "battery",
    visible: Battery.bind("available"),
    icon: Battery.bind("icon_name"),
  });

const Left = (/** @type {number} */ monitor) =>
  Widget.Box({
    children: [Workspaces(monitor)],
  });

const Center = (/** @type {number} */ monitor) =>
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
