import { bind } from 'astal';
import { App, Astal } from 'astal/gtk4';
import { Notification } from './Notification';
import { NotifiationMap } from './NotificationMap';
const { TOP, RIGHT } = Astal.WindowAnchor;

export const allNotifications = new NotifiationMap()
export default function Notifications() {
  let notif: Astal.Window;
  return <window
    name="notifications"
    anchor={TOP | RIGHT}
    application={App}
    visible={false}
    setup={(self) => notif = self}
  >
    <box vertical>
      {bind(allNotifications).as((n) => {
        if (notif)
          (n.length == 0)
            ? notif.hide()
            : notif.show()

        return n.map(Notification)
      }
      )}

    </box>
  </window>
}
