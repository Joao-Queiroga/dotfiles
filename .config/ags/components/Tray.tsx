import { createBinding, For, onCleanup } from "ags";
import { Gdk, Gtk } from "ags/gtk4";
import AstalTray from "gi://AstalTray";
import Gio from "gi://Gio?version=2.0";

const TrayItem = ({ item }: { item: AstalTray.TrayItem }) => (
  <menubutton class="tray-item" tooltip_markup={createBinding(item, "tooltipMarkup")}>
    <Gtk.GestureClick
      button={0}
      propagationPhase={Gtk.PropagationPhase.CAPTURE}
      onPressed={self => {
        const button = self.get_current_button();
        if (button === Gdk.BUTTON_SECONDARY || (item.isMenu && button === Gdk.BUTTON_PRIMARY)) {
          item.about_to_show();
        }
        self.set_state(Gtk.EventSequenceState.CLAIMED);
      }}
      onReleased={(self, _, x, y) => {
        const menubutton = self.get_widget() as Gtk.MenuButton;
        const button = self.get_current_button();
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
        self.set_state(Gtk.EventSequenceState.CLAIMED);
      }}
    />
    <image class="tray-icon" gicon={createBinding(item, "gicon")} />
    <Gtk.PopoverMenu
      flags={Gtk.PopoverMenuFlags.NESTED}
      menu_model={createBinding(item, "menuModel")}
      has_arrow={false}
      $={self => {
        self.insert_action_group("dbusmenu", item.actionGroup);
        const ag = item.actionGroup.connect("notify", (ag: Gio.ActionGroup) =>
          self.insert_action_group("dbusmenu", ag),
        );
        onCleanup(() => item.disconnect(ag));
      }}
    />
  </menubutton>
);

export const Tray = () => {
  const tray = AstalTray.get_default();

  return (
    <box class="systray">
      <For each={createBinding(tray, "items")}>{(item: AstalTray.TrayItem) => <TrayItem item={item} />}</For>
    </box>
  );
};
