import { bind } from "astal";
import { Gdk, Gtk } from "astal/gtk4";
import AstalTray from "gi://AstalTray";
import { PopoverMenu } from "../../lib/customWidgets/PopoverMenu";

const TrayItem = (item: AstalTray.TrayItem) => {
  const menu = (
    <PopoverMenu
      flags={Gtk.PopoverMenuFlags.NESTED}
      menuModel={bind(item, "menuModel")}
      setup={self => {
        bind(item, "actionGroup").as(ag => self.insert_action_group("dbusmenu", ag));
      }}
    />
  ) as Gtk.PopoverMenu;
  return (
    <box cssClasses={["tray-item"]}>
      <button
        tooltipMarkup={bind(item, "tooltip_markup")}
        onButtonPressed={(_, event) => {
          switch (event.get_button()) {
            case Gdk.BUTTON_PRIMARY:
              if (item.isMenu) {
                menu.popup();
              } else {
                const [_, x, y] = event.get_position();
                item.activate(x, y);
              }
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
};

export const Systray = () => {
  const tray = AstalTray.get_default();

  return <box cssClasses={["systray"]}>{bind(tray, "items").as(items => items.map(TrayItem))}</box>;
};
