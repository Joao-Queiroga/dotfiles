import { NotifiationMap } from "./NotificationMap";
import { Astal, For, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { Notification } from "./Notification";

export const allNotifications = new NotifiationMap();
export default function Notifications() {
  const { TOP, RIGHT } = Astal.WindowAnchor;
  return (
    <window name="notifications" anchor={TOP | RIGHT} application={app} visible={allNotifications(n => n.length > 0)}>
      <box orientation={Gtk.Orientation.VERTICAL}>
        <For each={allNotifications()}>{n => <Notification notification={n} />}</For>
      </box>
    </window>
  );
}
