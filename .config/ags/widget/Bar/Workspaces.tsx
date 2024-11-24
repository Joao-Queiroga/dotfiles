import Hyprland from "gi://AstalHyprland";
import { Gtk } from "astal/gtk3";

const Workspace = ({ id }: { id: number }) => {
  const hypr = Hyprland.get_default();
  const handleClick = () => hypr.dispatch("workspace", id.toString());

  const setup = (self: any) => {
    self.hook(hypr, "event", () => {
      const workspace = hypr.get_workspace(id);
      self.toggleClassName("occupied", (workspace?.get_clients().length || 0) > 0);
      self.toggleClassName("active", hypr.get_focused_workspace().get_id() === id);
    });
  };

  return <button onClicked={handleClick} setup={setup}>
    <label className="indicator" halign={Gtk.Align.CENTER} label={id.toString()} />
  </button>
};

export default function Workspaces() {
  return <box className="workspaces">
    {Array.from({ length: 9 }, (_, i) => (
      <Workspace id={i + 1} />
    ))}
  </box>
}
