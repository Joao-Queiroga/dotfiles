import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import AstalApps from "gi://AstalApps";
import GLib from "gi://GLib";
import { For, createState } from "ags";
import Graphene from "gi://Graphene";
import { execAsync } from "ags/process";

const hide = () => app.get_window("launcher")!.hide();

const fileExists = (path: string | null) => GLib.file_test(path || "", GLib.FileTest.EXISTS);

const AppButton = ({ app }: { app: AstalApps.Application }) => (
  <button
    class="AppButton"
    onClicked={() => {
      hide();
      execAsync(["uwsm", "app", app.entry]);
    }}
  >
    <box>
      {(fileExists(app.icon_name) && <image file={app.icon_name} />) || <image icon_name={app.icon_name} />}
      <box orientation={Gtk.Orientation.VERTICAL}>
        <label class="name" xalign={0} label={app.name} />
        {app.description && (
          <label
            class="description"
            maxWidthChars={50}
            wrap
            xalign={0}
            label={app.description.length > 101 ? app.description.substring(0, 101) + "..." : app.description}
          />
        )}
      </box>
    </box>
  </button>
);

export default function AppLauncher() {
  const apps = new AstalApps.Apps();
  let entry: Gtk.Entry;
  let contentBox: Gtk.Box;
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

  const [text, setText] = createState("");
  const list = text(text => apps.fuzzy_query(text));
  const onEnter = () => {
    const app = apps.fuzzy_query(text.peek())?.[0];
    execAsync(["uwsm", "app", app.entry]);
    hide();
  };

  return (
    <window
      name="launcher"
      exclusivity={Astal.Exclusivity.IGNORE}
      visible={false}
      anchor={TOP | LEFT | RIGHT | BOTTOM}
      layer={Astal.Layer.OVERLAY}
      keymode={Astal.Keymode.EXCLUSIVE}
      application={app}
      onShow={() => {
        apps.reload();
        entry.grab_focus();
        entry.set_text("");
      }}
    >
      <Gtk.GestureClick
        onPressed={(source: Gtk.GestureClick, _: number, x: number, y: number) => {
          const win = source.widget as Gtk.Window;
          const [, rect] = contentBox.compute_bounds(win);
          const position = new Graphene.Point({ x, y });

          if (!rect.contains_point(position)) {
            hide();
          }
        }}
      />
      <Gtk.EventControllerKey
        onKeyPressed={({ widget }, keyval) => {
          if (keyval === Gdk.KEY_Escape) {
            widget.hide();
          }
        }}
      />
      <box
        widthRequest={500}
        heightRequest={500}
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        class="AppLauncher"
        orientation={Gtk.Orientation.VERTICAL}
        $={ref => (contentBox = ref)}
      >
        <entry
          placeholderText="Search"
          onActivate={onEnter}
          primaryIconName="system-search-symbolic"
          onNotifyText={self => setText(self.text)}
          text={text}
          $={ref => (entry = ref)}
        />
        <box
          halign={Gtk.Align.CENTER}
          orientation={Gtk.Orientation.VERTICAL}
          class="not-found"
          visible={list(l => l.length === 0)}
        >
          <image icon_name="system-search-symbolic" />
          <label label="No match found" />
        </box>
        <scrolledwindow class="AppList" vexpand>
          <box orientation={Gtk.Orientation.VERTICAL} spacing={6} visible={list(l => l.length > 0)}>
            <For each={list}>{app => <AppButton app={app} />}</For>
          </box>
        </scrolledwindow>
      </box>
    </window>
  );
}
