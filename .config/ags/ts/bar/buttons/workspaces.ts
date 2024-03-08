import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { range } from "../../utils.js";

const dispatch = (workspace: number) =>
  Hyprland.messageAsync(`dispatch workspace ${workspace}`);

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
          self.hook(Hyprland, () => {
            self.toggleClassName(
              "active",
              Hyprland.getMonitor(monitor)?.activeWorkspace.id === i,
            );
            self.toggleClassName(
              "occupied",
              (Hyprland.getWorkspace(i)?.windows || 0) > 0,
            );
          }),
      }),
    ),
  });

export default Workspaces;
