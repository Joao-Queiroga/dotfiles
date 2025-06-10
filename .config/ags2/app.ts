import { App } from "astal/gtk4";
import style from "./style/style.scss";
import Bar from "./widget/Bar";
import AppLauncher from "./widget/AppLauncher";
import Notifications from "./widget/Notifications";
import { requestHandler } from "./lib/messageHandler";
import PowerMenu from "./widget/PowerMenu";

App.start({
  css: style,
  requestHandler: requestHandler,
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(Notifications);
    AppLauncher();
    PowerMenu();
  },
});
