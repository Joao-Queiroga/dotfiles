import { App } from "astal/gtk4";
import style from "./style/style.scss";
import Bar from "./widget/Bar";
import AppLauncher from "./widget/AppLauncher";
import Notifications, { allNotifications } from "./widget/Notifications";

App.start({
  css: style,
  requestHandler(request, res) {
    if (request == "clearLastNotification") {
      allNotifications.dismissLastNotification();
      res("ok");
    }
    if (request == "clearAllNotifications") {
      allNotifications.dismissAllNotifications();
      res("ok");
    }
  },
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(Notifications);
    AppLauncher();
  },
});
