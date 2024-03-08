import { range } from "../../utils.js";

const hyprland = await Service.import("hyprland");

const dispatch = (workspace: number) =>
  hyprland.messageAsync(`dispatch workspace ${workspace}`);

const Workspaces = (monitor: number) =>
  Widget.Box({
    class_name: "workspaces",
    children: range(9, monitor * 10 + 1).map((i) =>
      Widget.Button({
        attribute: i,
        on_clicked: () => dispatch(i),
        child: Widget.Label({
          label: "",
          class_name: "indicator",
          vpack: "center",
        }),
        setup: (self) =>
          self.hook(hyprland, () => {
            self.toggleClassName(
              "active",
              hyprland.getMonitor(monitor)?.activeWorkspace.id === i,
            );
            self.toggleClassName(
              "occupied",
              (hyprland.getWorkspace(i)?.windows || 0) > 0,
            );
          }),
      }),
    ),
  });

export default Workspaces;
