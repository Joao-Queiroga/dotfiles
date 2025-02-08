import { App, Astal } from 'astal/gtk4';
import Notifd from 'gi://AstalNotifd';
import { Notification } from './Notification';
import { type Subscribable } from 'astal/binding';
import { Variable, bind, timeout } from 'astal';
const { TOP, RIGHT } = Astal.WindowAnchor;
export const DND = Variable(false);

const map: Map<number, Notifd.Notification> = new Map();
const notifications: Variable<Array<Notifd.Notification>> = new Variable([]);

class NotifiationMap implements Subscribable {
  private notifiy = () =>
    (!DND.get()) &&
    notifications.set([...map.values()].reverse());

  constructor() {
    const notifd = Notifd.get_default();

    notifd.connect("notified", (_, id) =>
      this.set(id, notifd.get_notification(id)!)
    );

    notifd.connect("resolved", (_, id) =>
      this.delete(id)
    );
  };

  private set(key: number, value: Notifd.Notification) {
    map.set(key, value);
    this.notifiy();
  };

  public delete(key: number) {
    let isDND;
    if (DND.get()) {
      isDND = true;
      DND.set(false);
    };

    map.delete(key);
    this.notifiy();

    (isDND) &&
      DND.set(true);
  };

  get = () => notifications.get();

  subscribe = (callback: (list: Array<Notifd.Notification>) => void) =>
    notifications.subscribe(callback);
};
const allNotifications = new NotifiationMap();

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

export const clearOldestNotification = () =>
  allNotifications.delete([...map][0][0]);
