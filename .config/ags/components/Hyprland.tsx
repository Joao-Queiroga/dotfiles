import { createBinding, createComputed, onCleanup, With } from "ags";
import { Gdk, Gtk } from "ags/gtk4";
import AstalHyprland from "gi://AstalHyprland";
import { guessIcon, range } from "../lib/utils";

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

export const Workspaces = ({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) => {
  const monitor = hypr.get_monitor_by_name(gdkmonitor.connector)!;
  return (
    <box class="workspaces">
      {range(monitor.id * 10 + 1, 9).map(i => (
        <Workspace id={i} />
      ))}
    </box>
  );
};

export const Client = ({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) => (
  <box visible={createBinding(hypr.get_monitor_by_name(gdkmonitor.connector)!, "focused")} class="client">
    <With value={createBinding(hypr, "focused_client")}>
      {(client: AstalHyprland.Client) =>
        client && (
          <box spacing={4}>
            <image icon_name={createBinding(client, "class").as(guessIcon)} />
            <label label={createBinding(client, "title").as(t => (t.length > 50 ? t.substring(0, 51) + "..." : t))} />
          </box>
        )
      }
    </With>
  </box>
);
