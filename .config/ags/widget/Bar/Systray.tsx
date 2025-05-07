import { bind } from "astal";
import { Gdk, Gtk, hook } from "astal/gtk4";
import AstalTray from "gi://AstalTray";

const createTrayMenu = (item: AstalTray.TrayItem): Gtk.PopoverMenu => {
  const popovermenu = Gtk.PopoverMenu.new_from_model(item.menuModel);
  popovermenu.insert_action_group("dbusmenu", item.actionGroup);
  hook(popovermenu, item, "notify::action-group", () => popovermenu?.insert_action_group("dbusmenu", item.actionGroup));
  hook(popovermenu, item, "notify::menumodel", () => popovermenu?.set_menu_model(item.menuModel));

  return popovermenu;
};

export const Systray = () => {
  const tray = AstalTray.get_default();

  return (
    <box cssClasses={["systray"]}>
      {bind(tray, "items").as(items =>
        items.map(item => {
          const menu = createTrayMenu(item);
          return (
            <box cssClasses={["tray-item"]}>
              <button
                tooltipMarkup={bind(item, "tooltip_markup")}
                onButtonPressed={(_, event) => {
                  switch (event.get_button()) {
                    case Gdk.BUTTON_PRIMARY:
                      item.activate(0, 0);
                      break;
                    case Gdk.BUTTON_SECONDARY:
                      menu.popup();
                  }
                }}
              >
                <image gicon={bind(item, "gicon")} />
              </button>
              {menu}
            </box>
          );
        }),
      )}
    </box>
  );
};
