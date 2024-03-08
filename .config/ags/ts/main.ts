import { forMonitors } from "./utils.ts";
import Bar from "./bar/bar.ts";

const scss = `${App.configDir}/style/style.scss`;
const css = "/tmp/ags/style.css";

Utils.exec(`sassc ${scss} ${css}`);

App.config({
  style: css,
  windows: [...forMonitors(Bar)],
});
