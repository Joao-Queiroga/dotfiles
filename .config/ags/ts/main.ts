/* import { forMonitors } from "./utils.js";
import Bar from "./bar/bar.js";

const Windows = [forMonitors(Bar)];

export default {
  windows: Windows,
}; */
import Widget from 'resource:///com/github/Aylur/ags/widget.js'

const Bar = (monitor: number) => Widget.Window({
    name: `bar-${monitor}`,
})

export default {
    windows: [Bar(0)]
}
