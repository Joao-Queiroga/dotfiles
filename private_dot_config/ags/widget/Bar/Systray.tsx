import { bind } from "astal";
import { hook } from "astal/gtk4";
import AstalTray from "gi://AstalTray";

export const Systray = () => {
  const tray = AstalTray.get_default()

  return <box cssClasses={['systray']}>
    {bind(tray, 'items').as(items => items.map(item => (
      <menubutton tooltip_markup={bind(item, 'tooltip_markup')}
        tooltipText={bind(item, 'tooltip_markup')}
        menuModel={bind(item, 'menuModel')}
        setup={self => hook(self, item, "notify::action-group", () => self.insert_action_group("dbusmenu", item.action_group))}>
        <image gicon={bind(item, 'gicon')} />
      </menubutton>
    )))}
  </box >
}
