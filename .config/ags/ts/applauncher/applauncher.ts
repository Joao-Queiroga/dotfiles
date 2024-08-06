import { Application } from "resource:///com/github/Aylur/ags/service/applications.js";

const { query, reload } = await Service.import("applications");
const WINDOW_NAME = "applauncher";

const AppItem = (app: Application) =>
  Widget.Button({
    on_clicked: () => {
      App.closeWindow(WINDOW_NAME);
      app.launch();
    },
    attribute: app,
    child: Widget.Box({
      children: [
        Widget.Icon({
          icon: app.icon_name || "",
          size: 42,
        }),
        Widget.Label({
          class_name: "title",
          label: app.name,
          xalign: 0,
          vpack: "center",
          truncate: "end",
        }),
      ],
    }),
  });

const AppLauncher = ({ width = 500, height = 500, spacing = 12 }) => {
  let applications = query("").map(AppItem);

  const list = Widget.Box({
    vertical: true,
    children: applications,
    spacing,
  });

  function repopulate() {
    reload();
    applications = query("").map(AppItem);
    list.children = applications;
  }

  const entry = Widget.Entry({
    hexpand: true,
    css: `margin-bottom: ${spacing}px;`,
    // to launch the first item on Enter
    on_accept: () => {
      const results = applications.filter((item) => item.visible);
      if (results[0]) {
        App.toggleWindow(WINDOW_NAME);
        results[0].attribute.launch();
      }
    },
    on_change: ({ text }) =>
      applications.forEach((item) => {
        item.visible = item.attribute.match(text ?? "");
      }),
  });

  return Widget.Box({
    vertical: true,
    css: `margin: ${spacing * 2}px;`,
    children: [
      entry,
      Widget.Scrollable({
        hscroll: "never",
        css: `min-width: ${width}px;` + `min-height: ${height}px;`,
        child: list,
      }),
    ],
    setup: (self) =>
      self.hook(App, (_, windowName, visible) => {
        if (windowName != WINDOW_NAME) return;

        if (visible) {
          repopulate();
          entry.text = "";
          entry.grab_focus();
        }
      }),
  });
};

export const applauncher = Widget.Window({
  name: WINDOW_NAME,
  setup: (self) => self.keybind("Escape", () => App.closeWindow(WINDOW_NAME)),
  visible: false,
  keymode: "exclusive",
  child: AppLauncher({
    width: 500,
    height: 500,
    spacing: 12,
  }),
});
