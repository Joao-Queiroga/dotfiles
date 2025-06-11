import app from "ags/gtk4/app";
import { requestHandler } from "./lib/messageHandler";
import style from "./style/style.scss";
import AppLauncher from "./widget/AppLauncher";
import Bar from "./widget/Bar";
import Notifications from "./widget/Notifications";
import Powermenu from "./widget/PowerMenu";

app.start({
  css: style,
  requestHandler: requestHandler,
  main() {
    app.get_monitors().map(Bar);
    app.get_monitors().map(Notifications);
    AppLauncher();
    Powermenu();
  },
});
