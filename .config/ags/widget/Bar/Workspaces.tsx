import Hyprland from "gi://AstalHyprland";
import { Gtk } from "astal/gtk3";
import { range } from "../../lib/util";

const Workspace = ({ id }: { id: number }) => {
  const hypr = Hyprland.get_default();
  const handleClick = () => hypr.dispatch("workspace", id.toString());

  const setup = (self: any) => {
    self.hook(hypr, "event", () => {
      const workspace = hypr.get_workspace(id);
      self.toggleClassName("active", hypr.get_focused_workspace().get_id() === id);
      self.toggleClassName("occupied", !!workspace);
    });
  };

  return <button onClicked={handleClick} setup={setup}>
    <label className="indicator" halign={Gtk.Align.CENTER} label={id.toString()} />
  </button>
};

export default function Workspaces() {
  return <box className="workspaces">
    {range(9).map(i => (
      <Workspace id={i} />
    ))}
  </box>
}
