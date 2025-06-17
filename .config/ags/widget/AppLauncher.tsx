import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import AstalApps from "gi://AstalApps";
import GLib from "gi://GLib";
import { For, createState } from "ags";

const hide = () => app.get_window("launcher")!.hide();

const fileExists = (path: string) => GLib.file_test(path, GLib.FileTest.EXISTS);

const AppButton = ({ app }: { app: AstalApps.Application }) => (
  <button
    class="AppButton"
    onClicked={() => {
      hide();
      app.launch();
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
  let contentBox: Gtk.Box;

  const [text, setText] = createState("");
  const list = text(text => apps.fuzzy_query(text));
  const onEnter = () => {
    apps.fuzzy_query(text.get())?.[0].launch();
    hide();
  };

  return (
    <window
      name="launcher"
      exclusivity={Astal.Exclusivity.IGNORE}
      visible={false}
      keymode={Astal.Keymode.ON_DEMAND}
      application={app}
      onShow={() => {
        apps.reload();
        setText("");
      }}
    >
      <Gtk.EventControllerFocus onLeave={() => hide()} />
      <Gtk.EventControllerKey
        onKeyPressed={({ widget }, keyval) => {
          if (keyval === Gdk.KEY_Escape) {
            widget.hide();
          }
        }}
      />
      <box
        $={ref => (contentBox = ref)}
        widthRequest={500}
        heightRequest={500}
        class="AppLauncher"
        orientation={Gtk.Orientation.VERTICAL}
      >
        <entry
          placeholderText="Search"
          onActivate={onEnter}
          primaryIconName="system-search-symbolic"
          onNotifyText={self => setText(self.text)}
          $={self =>
            app.connect("window-toggled", () => {
              if (app.get_window("launcher")?.visible) {
                self.grab_focus();
                self.text = "";
              }
            })
          }
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
        <Gtk.ScrolledWindow class="AppList" vexpand>
          <box orientation={Gtk.Orientation.VERTICAL} spacing={6} visible={list(l => l.length > 0)}>
            <For each={list}>{app => <AppButton app={app} />}</For>
          </box>
        </Gtk.ScrolledWindow>
      </box>
    </window>
  );
}
