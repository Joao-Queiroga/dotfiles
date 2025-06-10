import { bind } from "astal";
import { Gdk, Gtk } from "astal/gtk4";
import AstalTray from "gi://AstalTray";
import { PopoverMenu } from "../../lib/customWidgets/PopoverMenu";

const TrayItem = (item: AstalTray.TrayItem) => {
  return (
    <menubutton
      cssClasses={["tray-item"]}
      onButtonPressed={(_, event) => {
        const button = event.get_button();
        if (button == Gdk.BUTTON_SECONDARY || (item.is_menu && button == Gdk.BUTTON_PRIMARY)) {
          item.about_to_show();
        }
      }}
      onButtonReleased={(self, event) => {
        const button = event.get_button();
        const [_, x, y] = event.get_position();
        if (event.get_surface() != self.get_native()?.get_surface()) return;
        if (button == Gdk.BUTTON_PRIMARY) {
          if (item.isMenu) {
            self.popup();
          } else {
            item.activate(x, y);
          }
        } else if (button == Gdk.BUTTON_MIDDLE) {
          item.secondary_activate(x, y);
        } else {
          self.popup();
        }
      }}
    >
      <image cssClasses={["tray-icon"]} gicon={bind(item, "gicon")} />
      <PopoverMenu
        flags={Gtk.PopoverMenuFlags.NESTED}
        menuModel={bind(item, "menuModel")}
        hasArrow={false}
        setup={self => {
          self.insert_action_group("dbusmenu", item.actionGroup);
          bind(item, "actionGroup").as(ag => self.insert_action_group("dbusmenu", ag));
        }}
      />
    </menubutton>
  );
};

export const Systray = () => {
  const tray = AstalTray.get_default();

  return <box cssClasses={["systray"]}>{bind(tray, "items").as(items => items.sort().map(TrayItem))}</box>;
};
