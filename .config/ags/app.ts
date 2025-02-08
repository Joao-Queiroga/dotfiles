import { App } from "astal/gtk4";
import style from "./style/style.scss";
import Bar from "./widget/Bar";
import AppLauncher from "./widget/AppLauncher";
import Notifications from "./widget/Notifications";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(Notifications);
    AppLauncher();
  },
});
