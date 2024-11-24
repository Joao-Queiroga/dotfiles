import { GLib, Variable } from "astal";

const time = Variable(GLib.DateTime.new_now_local()).poll(1000, GLib.DateTime.new_now_local);

export default function Time({ format = "%H:%M" }) {

  return <label className="time"
    label={time(self => (self.format(format) || ""))} />
}
