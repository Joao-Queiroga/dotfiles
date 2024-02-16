import { forMonitors } from "./utils.ts";
import Bar from "./bar/bar.ts";
import Dashboard from "./dashboard/dashboard";

const Windows = [
  forMonitors(Bar),
  // forMonitors(Dashboard)
];

export default {
  windows: Windows,
};
