import { forMonitors } from "./utils.ts";
import Bar from "./bar/bar.ts";

const Windows = [forMonitors(Bar)];

export default {
  windows: Windows,
};
