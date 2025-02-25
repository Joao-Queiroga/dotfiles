import { bind } from "astal";
import { Gdk, Gtk, hook } from "astal/gtk4";
import AstalTray from "gi://AstalTray";

const createMenu = (item: AstalTray.TrayItem): Gtk.PopoverMenu => {
  const popovermenu = Gtk.PopoverMenu.new_from_model(item.menuModel)
  popovermenu.insert_action_group("dbusmenu", item.actionGroup)

  return popovermenu
}

export const Systray = () => {
  const tray = AstalTray.get_default()

  return <box cssClasses={['systray']}>
    {bind(tray, 'items').as(items => items.map(item => {
      const menu = createMenu(item)
      return <><button tooltip_markup={bind(item, 'tooltip_markup')}
        tooltipMarkup={bind(item, 'tooltip_markup')}
        onButtonPressed={(_, event) => {
          const button = event.get_button()
          if (button == Gdk.BUTTON_PRIMARY)
            item.activate(0, 0)
          else if (button == Gdk.BUTTON_SECONDARY)
            menu.popup()
        }}
        setup={_ => {
          hook(menu, item, "notify::action-group", () => menu?.insert_action_group("dbusmenu", item.actionGroup))
          hook(menu, item, "notify::menumodel", () => menu?.set_menu_model(item.menuModel))
        }}>
        <image gicon={bind(item, 'gicon')} />
      </button>
        {menu}
      </>
    }))}
  </box >
}
