import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { Notification } from "./Notification";
import AstalNotifd from "gi://AstalNotifd";
import { createBinding, createState, For, onCleanup } from "ags";

const [notifications, setNotifications] = createState<AstalNotifd.Notification[]>([]);

export const dismissLastNotification = () => notifications.get()[0].dismiss();
export const dismissAllNotifications = () => notifications.get().forEach(n => n.dismiss);

export default function Notifications() {
  const notifd = AstalNotifd.get_default();
  const { TOP, RIGHT } = Astal.WindowAnchor;
  const notifiedHandler = notifd.connect("notified", (_, id, replaced) => {
    const notification = notifd.get_notification(id)!;

    if (replaced) {
      setNotifications(ns => ns.map(n => (n.id === id ? notification : n)));
    } else {
      setNotifications(ns => [notification, ...ns]);
    }
  });
  const resolvedHandler = notifd.connect("resolved", (_, id) => setNotifications(ns => ns.filter(n => n.id !== id)));

  onCleanup(() => {
    notifd.disconnect(notifiedHandler);
    notifd.disconnect(resolvedHandler);
  });
  return (
    <For each={createBinding(app, "monitors")} cleanup={win => (win as Gtk.Window).destroy()}>
      {(monitor: Gdk.Monitor) => (
        <window
          gdkmonitor={monitor}
          name="notifications"
          anchor={TOP | RIGHT}
          application={app}
          visible={notifications(n => n.length > 0)}
          $={self => onCleanup(() => self.destroy())}
        >
          <box orientation={Gtk.Orientation.VERTICAL}>
            <For each={notifications}>{n => <Notification notification={n} />}</For>
          </box>
        </window>
      )}
    </For>
  );
}
