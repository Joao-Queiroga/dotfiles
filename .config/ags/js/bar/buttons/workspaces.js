import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { range } from "../../utils.js";

const dispatch = (workspace) =>
  execAsync(`hyprctl dispatch workspace ${workspace}`);

const Workspaces = (monitor) =>
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
        setup: (self) => {
          self.toggleClassName("active", Hyprland.active.workspace.id === i);
          self.toggleClassName(
            "occupied",
            (Hyprland.getWorkspace(i)?.windows || 0) > 0,
          );
        },
      }),
    ),
  });

export default Workspaces;
