import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import AstalWp from "gi://AstalWp";

export const VolumeSlider = () => {
  const speaker = AstalWp.get_default()?.audio.defaultSpeaker!;

  return (
    <box>
      <button iconName={bind(speaker, "volume_icon")} onClicked={() => speaker.set_mute(!speaker.get_mute())} />
      <slider hexpand onChangeValue={self => speaker.set_volume(self.value)} value={bind(speaker, "volume")} />
    </box>
  );
};
