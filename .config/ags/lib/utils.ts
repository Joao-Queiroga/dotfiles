import { Gdk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";

export const range = (length: number, start = 1) => Array.from({ length }, (_, i) => i + start);

export const GdkToHypr = (monitor: Gdk.Monitor) => {
  const hypr = AstalHyprland.get_default();

  return hypr.get_monitor_by_name(monitor.connector);
};
