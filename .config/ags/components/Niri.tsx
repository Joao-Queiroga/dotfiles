import { Gdk, Gtk } from "ags/gtk4";
import { exec, execAsync } from "ags/process";
import AstalNiri from "gi://AstalNiri";
import { createBinding, createComputed, For, onCleanup, With } from "gnim";
import { guessIcon } from "../lib/utils";

const niri = AstalNiri.get_default();

const Workspace = ({ id }: { id: number }) => (
  <button
    onClicked={() => execAsync(["niri", "msg", "action", "focus-workspace", id.toString()])}
    $={self => {
      const events = niri.connect("event-stream", () => {
        const w = niri.get_workspace(id);
        self.css_classes = [w?.get_is_active() && "active", (w?.get_windows().length || 0) > 0 && "occupied"].filter(
          Boolean,
        ) as string[];
      });
      onCleanup(() => {
        niri.disconnect(events);
      });
      const w = niri.get_workspace(id);
      self.css_classes = [w?.get_is_active() && "active", (w?.get_windows().length || 0) > 0 && "occupied"].filter(
        Boolean,
      ) as string[];
    }}
  >
    <label class="indicator" label={id.toString()} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} />
  </button>
);

export const NiriWorkspaces = ({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) => {
  const workspaces = createBinding(niri, "workspaces").as(ws => ws.filter(w => w.output === gdkmonitor.connector));
  return (
    <box class="workspaces">
      <For each={workspaces}>{(workspace: AstalNiri.Workspace) => workspace && <Workspace id={workspace.id} />}</For>
    </box>
  );
};

export const NiriClient = ({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) => (
  <box
    class="client"
    visible={createBinding(niri, "focusedWindow", "workspace", "output").as(o => o === gdkmonitor.connector)}
  >
    <With value={createBinding(niri, "focusedWindow")}>
      {(window: AstalNiri.Window) =>
        window && (
          <box spacing={4}>
            <image icon_name={createBinding(window, "app_id").as(guessIcon)} />
            <label label={createBinding(window, "title").as(t => (t.length > 50 ? t.substring(0, 51) + "..." : t))} />
          </box>
        )
      }
    </With>
  </box>
);
