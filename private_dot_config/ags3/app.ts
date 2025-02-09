import { App } from "astal/gtk3";
import style from "./style/style.scss";
import Bar from "./widget/Bar";
import Applauncher from "./widget/Applauncher";
import Notifications from "./widget/Notifications";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(Notifications);
    Applauncher();
  },
});
