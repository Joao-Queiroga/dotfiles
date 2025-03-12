import { execAsync, GLib, Variable } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import AstalApps from "gi://AstalApps";

const hide = () => App.get_window("launcher")!.hide()

const fileExists = (path: string) =>
  GLib.file_test(path, GLib.FileTest.EXISTS)

const AppButton = ({ app }: { app: AstalApps.Application }) => (
  <button
    cssClasses={['AppButton']}
    onClicked={() => {
      hide()
      execAsync(["uwsm", "app", "--", app.get_entry()])
    }}>
    <box>
      {fileExists(app.icon_name) &&
        <image file={app.icon_name} /> ||
        <image icon_name={app.icon_name} />}
      <box valign={Gtk.Align.CENTER} vertical>
        <label
          cssClasses={['name']}
          xalign={0}
          label={app.name}
        />
        {app.description && <label
          cssClasses={['description']}
          maxWidthChars={50}
          wrap
          xalign={0}
          label={app.description}
        />}
      </box>
    </box>
  </button>
)

export default function AppLauncher() {
  const apps = new AstalApps.Apps()

  const text = Variable("")
  const list = text(text => apps.fuzzy_query(text).slice(0, 8))
  const onEnter = () => {
    execAsync(["uwsm", "app", "--", apps.fuzzy_query(text.get())?.[0].get_entry()])
    hide();
  }

  return <window
    name="launcher"
    exclusivity={Astal.Exclusivity.IGNORE}
    visible={false}
    keymode={Astal.Keymode.EXCLUSIVE}
    application={App}
    onShow={() => { apps.reload(); text.set("") }}
    onKeyPressed={(_, keyval) => {
      (keyval == Gdk.KEY_Escape) && hide()
    }}>
    <box widthRequest={500} heightRequest={500} cssClasses={['AppLauncher']} vertical>
      <entry
        placeholder_text="Search"
        primaryIconName="system-search-symbolic"
        onNotifyText={self => text.set(self.text)}
        onActivate={onEnter}
        setup={self =>
          App.connect('window-toggled', () => {
            if (App.get_window("launcher")?.visible) {
              self.grab_focus()
              self.text = ""
            }
          }
          )
        }
      />
      <box cssClasses={['AppList']} spacing={6} vertical visible={list.as(l => l.length > 0)}>
        {list.as(list => list.map(app => (
          <AppButton app={app} />
        )))}
      </box>
      <box
        halign={Gtk.Align.CENTER}
        cssClasses={['not-found']}
        vertical
        visible={list.as(l => l.length === 0)}>
        <image icon_name="system-search-symbolic" />
        <label label="No match found" />
      </box>
    </box>
  </window>
}
