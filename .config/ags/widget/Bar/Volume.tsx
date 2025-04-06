import { bind } from "astal";
import AstalWp from "gi://AstalWp";

export const Volume = () => {
  const speaker = AstalWp.get_default()?.audio.defaultSpeaker!;
  return (
    <button
      cssClasses={["volume"]}
      tooltip_markup={bind(speaker, "volume").as(vol => `${Math.floor(vol * 100)}%`)}
      onClicked={() => speaker.set_mute(!speaker.get_mute())}
    >
      <image icon_name={bind(speaker, "volume_icon")} />
    </button>
  );
};
