import { bind } from "astal";
import Tray from "gi://AstalTray"

export default function SysTray() {
  const tray = Tray.get_default();

  return <box className="systray">
    {bind(tray, "items").as(items => items.map(item => (
      <menubutton
        tooltipMarkup={bind(item, "tooltipMarkup")}
        usePopover={false}
        menuModel={bind(item, "menuModel")}
        actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}>
        <icon gicon={bind(item, "gicon")} />
      </menubutton>
    )))}
  </box>
}
