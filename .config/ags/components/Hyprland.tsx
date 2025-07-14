import { createBinding, onCleanup, With } from "ags";
import { Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland";
import { range } from "../lib/utils";

const hypr = AstalHyprland.get_default();

const Workspace = ({ id }: { id: number }) => (
  <button
    onClicked={() => hypr.dispatch("workspace", id.toString())}
    $={self => {
      const events = hypr.connect("event", () => {
        const workspace = hypr.get_workspace(id);
        const active = hypr.get_focused_workspace().get_id() === id;
        const occupied = !!workspace;
        self.cssClasses = [active && "active", occupied && "occupied"].filter(Boolean) as string[];
        if (active) {
          self.remove_css_class("urgent");
        }
      });
      const urgent = hypr.connect("urgent", (_, client) => client.workspace.id === id && self.add_css_class("urgent"));
      onCleanup(() => {
        hypr.disconnect(events);
        hypr.disconnect(urgent);
      });
    }}
  >
    <label class="indicator" label={id.toString()} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} />
  </button>
);

export const Workspaces = () => (
  <box class="workspaces">
    {range(9).map(i => (
      <Workspace id={i} />
    ))}
  </box>
);

export const Client = () => {
  const focused = createBinding(hypr, "focusedClient");
  return (
    <box visible={focused(Boolean)} class="client">
      <With value={focused}>
        {(client: AstalHyprland.Client) =>
          client && (
            <box spacing={4}>
              <image icon_name={client.class} />
              <label label={createBinding(client, "title")(t => (t.length > 50 ? t.substring(0, 51) + "..." : t))} />
            </box>
          )
        }
      </With>
    </box>
  );
};
