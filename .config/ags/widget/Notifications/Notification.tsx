import { Gdk, Gtk } from "ags/gtk4";
import { timeout } from "ags/time";
import AstalNotifd from "gi://AstalNotifd";
import GLib from "gi://GLib";
import Pango from "gi://Pango?version=1.0";
const { START, CENTER, END } = Gtk.Align;

const TIMEOUT_DELAY = 5000;

const time = (time: number, format = "%H:%M") => GLib.DateTime.new_from_unix_local(time).format(format);

export const Notification = ({ notification: n }: { notification: AstalNotifd.Notification }) => (
  <box orientation={Gtk.Orientation.VERTICAL} class="notification" $={() => timeout(TIMEOUT_DELAY, () => n.dismiss())}>
    <box class="header">
      {(n.app_icon || n.desktop_entry) && <image class="app-icon" iconName={n.app_icon || n.desktop_entry} />}
      <label class="app-name" halign={START} ellipsize={Pango.EllipsizeMode.END} label={n.app_name || "Unkwnow"} />
      <label class="time" hexpand halign={END} label={time(n.time)!} />
      <button $clicked={() => n.dismiss()} icon_name="window-close-symbolic" />
    </box>
    <box class="content" orientation={Gtk.Orientation.VERTICAL}>
      <label class="summary" halign={START} wrap xalign={0} label={n.summary} maxWidthChars={1} />
      {n.image && n.get_hint("internal") && <image file={n.image} heightRequest={100} widthRequest={100} />}
      {n.body && <label class="body" wrap xalign={0} label={n.body} maxWidthChars={1} />}
      {n.actions.length > 0 && (
        <box class="actions" spacing={5}>
          {n.actions.map(({ label, id }) => (
            <button
              hexpand
              cursor={Gdk.Cursor.new_from_name("pointer")}
              $clicked={() => {
                n.invoke(id);
                n.dismiss();
              }}
              label={label}
            />
          ))}
        </box>
      )}
    </box>
  </box>
);
