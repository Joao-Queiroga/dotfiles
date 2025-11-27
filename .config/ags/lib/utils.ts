import { Gdk, Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import AstalApps from "gi://AstalApps?version=0.1";

export const range = (start = 0, length: number) => Array.from({ length }, (_, i) => i + start);

export const GdkToHypr = (monitor: Gdk.Monitor) => {
  const hypr = AstalHyprland.get_default();

  return hypr.get_monitor_by_name(monitor.connector);
};

const iconTheme = Gtk.IconTheme.get_for_display(Gdk.Display.get_default()!);
const apps = new AstalApps.Apps();

export const iconExists = (name: string): boolean => iconTheme.has_icon(name);

const substitutions: Record<string, string> = {
  "code-url-handler": "visual-studio-code",
  Code: "visual-studio-code",
  "gnome-tweaks": "org.gnome.tweaks",
  "pavucontrol-qt": "pavucontrol",
  wps: "wps-office2019-kprometheus",
  wpsoffice: "wps-office2019-kprometheus",
  footclient: "foot",
};

const regexSubstitutions = [
  { regex: /^steam_app_(\d+)$/, replace: "steam_icon_$1" },
  { regex: /Minecraft.*/, replace: "minecraft" },
  { regex: /.*polkit.*/, replace: "system-lock-screen" },
  { regex: /gcr.prompter/, replace: "system-lock-screen" },
];

const getReverseDomainNameAppName = (name: string): string => {
  const parts = name.split(".");
  return parts.length > 1 ? parts[parts.length - 1] : name;
};

const getKebabNormalizedAppName = (name: string): string =>
  name
    .replace(/([a-z])([A-Z])/g, "$1-$2") // camelCase -> camel-Case
    .replace(/[\s_]+/g, "-") // espaços/underscores -> -
    .toLowerCase();

export const guessIcon = (str: string): string => {
  if (!str || str.length === 0) return "image-missing";
  str = str
    .replace(/^\./, "") // remove ponto no início
    .replace(/-wrapped$/, ""); // remove "wrapped" no final

  // Fuzzy nos desktop entries do sistema
  const results = apps.fuzzy_query(str);
  if (results.length > 0) {
    const guess = results[0].icon_name;
    if (guess && iconExists(guess)) return guess;
  }

  // Substituições normais
  if (substitutions[str]) return substitutions[str];
  if (substitutions[str.toLowerCase()]) return substitutions[str.toLowerCase()];

  // Regex substitutions
  for (const substitution of regexSubstitutions) {
    const replacedName = str.replace(substitution.regex, substitution.replace);
    if (replacedName !== str) return replacedName;
  }

  // Verificação direta
  if (iconExists(str)) return str;

  const lowercased = str.toLowerCase();
  if (iconExists(lowercased)) return lowercased;

  const reverseDomainNameAppName = getReverseDomainNameAppName(str);
  if (iconExists(reverseDomainNameAppName)) return reverseDomainNameAppName;

  const lowercasedDomainNameAppName = reverseDomainNameAppName.toLowerCase();
  if (iconExists(lowercasedDomainNameAppName)) return lowercasedDomainNameAppName;

  const kebabNormalizedGuess = getKebabNormalizedAppName(str);
  if (iconExists(kebabNormalizedGuess)) return kebabNormalizedGuess;

  // Desistir e devolver o próprio nome
  return str;
};
