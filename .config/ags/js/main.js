import { forMonitors } from "./utils.js";
import Bar from "./bar/bar.js";

const Windows = [forMonitors(Bar)];

export default {
  windows: Windows,
};
