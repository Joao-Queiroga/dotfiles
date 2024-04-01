import { forMonitors } from "./utils.ts";
import Bar from "./bar/bar.ts";
import { compileCss, reapplyCss } from "./applycss";

App.config({
  style: compileCss(),
  windows: [...forMonitors(Bar)],
});

const watchCss = Utils.monitorFile(`${App.configDir}/style`, (file, event) =>
  reapplyCss(),
);
