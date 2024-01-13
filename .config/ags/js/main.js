import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import Bar from "./bar/bar.js";

// had to use exec since Hyprland.monitors was returning a empty array
const monitors = execAsync(["hyprctl", "monitors", "-j"])
  .then((res) => JSON.parse(res))
  .catch((_) => undefined);

export default {
  closeWindowDelay: {
    "window-name": 500, // milliseconds
  },
  windows: [...(await monitors)?.map((monitor) => Bar(monitor.id))],
};
