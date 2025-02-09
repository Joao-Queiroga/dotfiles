import { bind } from 'astal';
import { App, Astal } from 'astal/gtk4';
import { Notification } from './Notification';
import { NotifiationMap } from './NotificationMap';

export const allNotifications = new NotifiationMap()
export default function Notifications() {
  const { TOP, RIGHT } = Astal.WindowAnchor;
  return <window
    name="notifications"
    anchor={TOP | RIGHT}
    application={App}
    visible={bind(allNotifications).as(n => n.length > 0)}
  >
    <box vertical>
      {bind(allNotifications).as((n) => n.map(Notification))}
    </box>
  </window>
}
