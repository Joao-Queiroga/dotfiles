import { bind } from "astal"
import { hook } from "astal/gtk4"
import AstalHyprland from "gi://AstalHyprland"
import Gtk from "gi://Gtk"
import { range } from "../../lib/util"

const hypr = AstalHyprland.get_default()

const Workspace = ({ id }: { id: number }) => {
  const handleClick = () => hypr.dispatch("workspace", id.toString())

  // Temporary solution
  return <button onClicked={handleClick} setup={self => hook(self, hypr, 'event', () => {
    const workspace = hypr.get_workspace(id);
    const active = hypr.get_focused_workspace().get_id() === id
    const occupied = !!workspace
    self.cssClasses = [active && 'active', occupied && 'occupied'].filter(Boolean) as string[]
  })}>
    <label cssClasses={['indicator']} halign={Gtk.Align.CENTER} label={id.toString()} />
  </button>
}

export const Workspaces = () => {
  return <box cssClasses={['workspaces']}>
    {range(9).map(i => (
      <Workspace id={i} />
    ))}
  </box>
}

export const FocusedClient = () => {
  const focused = bind(hypr, 'focused_client')
  return <box visible={focused.as(Boolean)}>
    {focused.as(client => (
      client && <label maxWidthChars={50} overflow={Gtk.Overflow.HIDDEN} label={bind(client, "title")} />
    ))}
  </box>
}
