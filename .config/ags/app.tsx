import app from "ags/gtk4/app";
import { requestHandler } from "./lib/messageHandler";
import style from "./style/style.scss";
import AppLauncher from "./widget/AppLauncher";
import Bar from "./widget/Bar";
import Notifications from "./widget/Notifications";
import Powermenu from "./widget/PowerMenu";
import { createBinding, For, This } from "gnim";
import { Gdk } from "ags/gtk4";

app.start({
  css: style,
  requestHandler: requestHandler,
  main() {
    const monitors = createBinding(app, "monitors");
    AppLauncher();
    Powermenu();
    return (
      <For each={monitors}>
        {(monitor: Gdk.Monitor) => (
          <This this={app}>
            <Bar gdkmonitor={monitor} />
            <Notifications gdkmonitor={monitor} />
          </This>
        )}
      </For>
    );
  },
});
