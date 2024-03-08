import { forMonitors } from "./utils.ts";
import Bar from "./bar/bar.ts";
import Dashboard from "./dashboard/dashboard";
import { exec } from "resource:///com/github/Aylur/ags/utils.js";
import App from "resource:///com/github/Aylur/ags/app.js";

const scss = `${App.configDir}/style.scss`;
const css = "/tmp/ags/style.css";

exec(`sassc ${scss} ${css}`);

const Windows = [
  forMonitors(Bar),
  // forMonitors(Dashboard)
];

App.config({
  style: css,
  windows: Windows,
});
