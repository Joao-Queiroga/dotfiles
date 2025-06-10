import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk4";
import AstalNetwork from "gi://AstalNetwork";

const network = AstalNetwork.get_default();

const access_points = () => {
  return (
    <box vertical overflow={Gtk.Overflow.HIDDEN}>
      {bind(network.wifi, "access_points").as(aps =>
        aps.map(ap => (
          <box>
            <image iconName={ap.iconName} />
            <label label={ap.ssid} />
          </box>
        )),
      )}
    </box>
  );
};

const icon = Variable.derive(
  [bind(network, "primary"), bind(network.wired, "iconName"), bind(network.wifi, "iconName")],
  (primary, wired_icon, wifi_icon): string => (primary === AstalNetwork.Primary.WIFI ? wifi_icon : wired_icon),
);
const name = Variable.derive([bind(network, "primary"), bind(network.wifi, "ssid")], (primary, ssid): string =>
  primary === AstalNetwork.Primary.WIFI ? ssid : "Wired",
);

export const NetworkName = () => (
  <box>
    <image iconName={icon()} />
    <label label={name()} />
  </box>
);
