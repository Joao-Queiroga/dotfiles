import { Gtk, With } from "ags/gtk4";
import { bind, hook } from "ags/state";
import AstalApps from "gi://AstalApps?version=0.1";
import AstalHyprland from "gi://AstalHyprland";
import { range } from "../../lib/utils";

const hypr = AstalHyprland.get_default();

const Workspace = ({ id }: { id: number }) => (
  <button
    $clicked={() => hypr.dispatch("workspace", id.toString())}
    $={self => {
      hook(self, hypr, "event", () => {
        const workspace = hypr.get_workspace(id);
        const active = hypr.get_focused_workspace().get_id() === id;
        const occupied = !!workspace;
        self.cssClasses = [active && "active", occupied && "occupied"].filter(Boolean) as string[];
        if (active) {
          self.remove_css_class("urgent");
        }
      });
      hook(self, hypr, "urgent", (_, client: AstalHyprland.Client) => {
        client.workspace.id === id && self.add_css_class("urgent");
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

const icon = (client: AstalHyprland.Client) => {
  const apps = new AstalApps.Apps();
  return apps.get_list().find(app => app.wmClass === client.class)?.iconName;
};

export const Client = () => {
  const focused = bind(hypr, "focusedClient");
  return (
    <box visible={focused.as(Boolean)} class="client">
      <With value={focused} cleanup={label => label.run_dispose()}>
        {client =>
          client && (
            <box spacing={4}>
              <image iconName={client.class} />
              <label label={bind(client, "title")} />
            </box>
          )
        }
      </With>
    </box>
  );
};
