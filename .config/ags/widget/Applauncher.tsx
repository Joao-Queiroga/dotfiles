import Apps from "gi://AstalApps"
import { App, Astal, Gdk, Gtk } from "astal/gtk3"
import { Variable } from "astal"

function hide() {
  App.get_window("launcher")!.hide()
}

function AppButton({ app }: { app: Apps.Application }) {
  return <button
    className="AppButton"
    onClicked={() => { hide(); app.launch() }}>
    <box>
      <icon icon={app.iconName} />
      <box valign={Gtk.Align.CENTER} vertical>
        <label
          className="name"
          truncate
          xalign={0}
          label={app.name}
        />
        {app.description && <label
          className="description"
          wrap
          xalign={0}
          label={app.description}
        />}
      </box>
    </box>
  </button>
}

export default function Applauncher() {
  const apps = new Apps.Apps()

  const text = Variable("")
  const list = text(text => apps.fuzzy_query(text))
  const onEnter = () => {
    apps.fuzzy_query(text.get())?.[0].launch()
    hide()
  }

  const Entry = <entry
    placeholderText="Search"
    text={text()}
    onChanged={self => text.set(self.text)}
    onActivate={onEnter}
  />

  return <window
    name="launcher"
    visible={false}
    exclusivity={Astal.Exclusivity.IGNORE}
    keymode={Astal.Keymode.EXCLUSIVE}
    application={App}
    onShow={() => { apps.reload(); text.set(""); Entry.grab_focus() }}
    onKeyPressEvent={function (self, event: Gdk.Event) {
      if (event.get_keyval()[1] === Gdk.KEY_Escape)
        self.hide()
    }}>
    <box widthRequest={500} heightRequest={500} className="Applauncher" vertical>
      {Entry}
      <scrollable vexpand vscrollbarPolicy={Gtk.PolicyType.EXTERNAL}>
        <box className="AppList" spacing={6} vertical>
          {list.as(list => list.map(app => (
            <AppButton app={app} />
          )))}
        </box>
      </scrollable>
      <box
        halign={Gtk.Align.CENTER}
        className="not-found"
        vertical
        visible={list.as(l => l.length === 0)}>
        <icon icon="system-search-symbolic" />
        <label label="No match found" />
      </box>
    </box>
  </window>
}
