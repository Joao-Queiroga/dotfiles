import Notifd from "gi://AstalNotifd";
import { type Subscribable } from "astal/binding";
import { Variable } from "astal";

export class NotifiationMap implements Subscribable {
  private map: Map<number, Notifd.Notification> = new Map();
  private var: Variable<Array<Notifd.Notification>> = new Variable([]);
  private notifiy = () => this.var.set([...this.map.values()].reverse());

  constructor() {
    const notifd = Notifd.get_default();

    notifd.connect("notified", (_, id) => this.set(id, notifd.get_notification(id)!));

    notifd.connect("resolved", (_, id) => this.delete(id));
  }

  private set(key: number, value: Notifd.Notification) {
    this.map.set(key, value);
    this.notifiy();
  }

  private delete(key: number) {
    this.map.delete(key);
    this.notifiy();
  }

  public get = () => this.var.get();

  public subscribe = (callback: (list: Array<Notifd.Notification>) => void) => this.var.subscribe(callback);

  public dismissLastNotification = () => {
    this.get()[0].dismiss();
  };

  public dismissAllNotifications = () => {
    this.get().forEach(n => n.dismiss());
  };
}
