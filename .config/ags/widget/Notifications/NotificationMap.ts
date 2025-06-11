import Notifd from "gi://AstalNotifd";
import { State } from "ags/state";

export class NotifiationMap extends State<Array<Notifd.Notification>> {
  private map: Map<number, Notifd.Notification> = new Map();
  private notifiy = () => this.set([...this.map.values()].reverse());

  constructor() {
    super([]);
    const notifd = Notifd.get_default();

    notifd.connect("notified", (_, id) => this.mapset(id, notifd.get_notification(id)!));

    notifd.connect("resolved", (_, id) => this.delete(id));
  }

  private mapset(key: number, value: Notifd.Notification) {
    this.map.set(key, value);
    this.notifiy();
  }

  private delete(key: number) {
    this.map.delete(key);
    this.notifiy();
  }

  public dismissLastNotification = () => {
    this.get()[0].dismiss();
  };

  public dismissAllNotifications = () => {
    this.get().forEach(n => n.dismiss());
  };
}
