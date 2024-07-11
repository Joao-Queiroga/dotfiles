import { forMonitors } from "./utils.ts";
import Bar from "./bar/bar.ts";
import { compileCss, reapplyCss } from "./applycss";
import { applauncher } from "./applauncher/applauncher";

App.config({
  style: compileCss(),
  windows: [...forMonitors(Bar), applauncher],
});

Utils.monitorFile(`${App.configDir}/style`, reapplyCss);
