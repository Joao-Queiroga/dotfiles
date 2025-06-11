import { For, Gdk, Gtk } from "ags/gtk4";
import { bind } from "ags/state";
import AstalTray from "gi://AstalTray";

const TrayItem = ({ item }: { item: AstalTray.TrayItem }) => (
  <menubutton class="tray-item" tooltip_markup={bind(item, "tooltipMarkup")}>
    <Gtk.EventControllerLegacy
      propagationPhase={Gtk.PropagationPhase.CAPTURE}
      $event={(self, event: Gdk.ButtonEvent) => {
        const menubutton = self.get_widget() as Gtk.MenuButton;

        const type = event.get_event_type();
        if (type === Gdk.EventType.BUTTON_PRESS) {
          const button = (event as Gdk.ButtonEvent).get_button();
          if (button === Gdk.BUTTON_SECONDARY || (item.is_menu && button === Gdk.BUTTON_PRIMARY)) {
            item.about_to_show();
          }
        }
        if (type === Gdk.EventType.BUTTON_RELEASE) {
          const button = (event as Gdk.ButtonEvent).get_button();
          const [_, x, y] = event.get_position();
          if (event.get_surface() != menubutton.get_native()?.get_surface()) return;
          if (button === Gdk.BUTTON_PRIMARY) {
            if (item.isMenu) {
              menubutton.popup();
            } else {
              item.activate(x, y);
            }
          } else if (button === Gdk.BUTTON_MIDDLE) {
            item.secondary_activate(x, y);
          } else {
            menubutton.popup();
          }
        }
        return true;
      }}
    />
    <image class="tray-icon" gicon={bind(item, "gicon")} />
    <Gtk.PopoverMenu
      flags={Gtk.PopoverMenuFlags.NESTED}
      menu_model={bind(item, "menuModel")}
      has_arrow={false}
      $={self => bind(item, "actionGroup").subscribe(self, ag => self.insert_action_group("dbusmenu", ag))}
    />
  </menubutton>
);

export const Tray = () => {
  const tray = AstalTray.get_default();

  return (
    <box class="systray">
      <For each={bind(tray, "items")}>{item => <TrayItem item={item} />}</For>
    </box>
  );
};
Gdk.BUTTON_PRIMARY;
