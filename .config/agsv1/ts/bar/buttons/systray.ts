import { TrayItem } from "types/service/systemtray";

const systray = await Service.import("systemtray");

const SysTrayItem = (item: TrayItem) =>
  Widget.Button({
    child: Widget.Icon().bind("icon", item, "icon"),
    tooltip_markup: item.bind("tooltip_markup"),
    on_primary_click: (_: any, event: any) => item.activate(event),
    on_secondary_click: (_: any, event: any) => item.openMenu(event),
  });

const SysTray = () =>
  Widget.Box({
    class_name: "systray",
  }).bind("children", systray, "items", (i) => i.map(SysTrayItem));

export default SysTray;
