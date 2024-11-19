import System from "./boxes/system/system";

const widgets = () =>
  Widget.Box({
    children: [System()],
  });

export default () =>
  Widget.Window({
    class_name: "dashboard",
    child: widgets(),
    exclusivity: "ignore",
    layer: "background",
  });
