import Gdk from "gi://Gdk";

export function range(length: number, start = 1): Array<number> {
  return Array.from({ length }, (_, i) => i + start);
}

export function forMonitors(
  widget: (monitor: number) => any,
): Array<import("types/widgets/window").default> {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).map(widget).flat(1);
}

export function truncateString(str: string, maxLength: number): string {
  return str.length <= maxLength ? str : str.slice(0, maxLength) + "...";
}
