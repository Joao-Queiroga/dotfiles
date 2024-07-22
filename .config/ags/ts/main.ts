import { forMonitors } from "./utils.ts";
import Bar from "./bar/bar.ts";
import { compileCss, reapplyCss } from "./applycss";
import { applauncher } from "./applauncher/applauncher";
import { NotificationPopups } from "./notifications/notifications";

App.config({
  style: compileCss(),
  windows: [
    ...forMonitors(Bar),
    ...forMonitors(NotificationPopups),
    applauncher,
  ],
});

Utils.monitorFile(`${App.configDir}/style`, reapplyCss);
