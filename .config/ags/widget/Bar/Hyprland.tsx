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

export const FocusedClient = () =>
  <label label={bind(hypr, 'focused_client').as(c => c.title)} />
