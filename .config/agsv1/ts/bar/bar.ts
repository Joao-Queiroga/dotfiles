import SysTray from "./buttons/systray.ts";
import Volume from "./buttons/volume.ts";
import BatteryIcon from "./buttons/battery";
import Workspaces from "./buttons/workspaces.ts";

const hyprland = await Service.import("hyprland");

const ClientTitle = (monitor: number) =>
  Widget.Label({
    class_name: "client-title",
    setup: (self) =>
      self.hook(hyprland.active, () => {
        const activeMonitor = hyprland.active.monitor;
        const activeClient = hyprland.active.client;
        const monitorWorkspace = hyprland.getMonitor(monitor)?.activeWorkspace;
        const workspace = hyprland.getWorkspace(monitorWorkspace?.id || 0);
        self.label =
          activeMonitor.id === monitor
            ? activeClient.title
            : workspace?.lastwindowtitle || "";
      }),
    max_width_chars: 24,
    truncate: "end",
  });

const Clock = () =>
  Widget.Label({
    class_name: "clock",
    setup: (self) =>
      self.poll(1000, (self) =>
        Utils.execAsync(["date", "+%a %d/%m/%Y %H:%M"]).then(
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
