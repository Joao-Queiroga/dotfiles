import App from "resource:///com/github/Aylur/ags/app.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import Bar from "./bar.js";

// had to use exec since Hyprland.monitors was returning a empty array
const monitors = execAsync(["hyprctl", "monitors", "-j"])
  .then((res) => JSON.parse(res))
  .catch((_) => undefined);

const scss = App.configDir + "/style.scss";
const css = App.configDir + "/style.css";

exec(`sassc ${scss} ${css}`);

export default {
  closeWindowDelay: {
    "window-name": 500, // milliseconds
  },
  notificationPopupTimeout: 5000, // milliseconds
  cacheNotificationActions: false,
  maxStreamVolume: 1.5, // float
  style: css,
  windows: [...(await monitors)?.map((monitor) => Bar(monitor.id))],
};
