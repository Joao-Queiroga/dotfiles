import Widget from "resource:///com/github/Aylur/ags/widget.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";

const SysTrayItem = (item) =>
  Widget.Button({
    child: Widget.Icon().bind("icon", item, "icon"),
    tooltipMarkup: item.bind("tooltip-markup"),
    on_primary_click: (_, event) => item.activate(event),
    on_secondary_click: (_, event) => item.openMenu(event),
  });

const SysTray = () =>
  Widget.Box({
    class_name: "systray",
  }).bind("children", SystemTray, "items", (i) => i.map(SysTrayItem));

export default SysTray;
