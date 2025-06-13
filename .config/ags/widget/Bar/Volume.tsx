import { createBinding } from "ags";
import AstalWp from "gi://AstalWp";

export const Volume = () => {
  const speaker = AstalWp.get_default()?.audio.defaultSpeaker!;
  return (
    <button
      class="volume"
      tooltip_markup={createBinding(speaker, "volume")(vol => `${Math.floor(vol * 100)}%`)}
      $clicked={() => speaker.set_mute(!speaker.get_mute())}
    >
      <image icon_name={createBinding(speaker, "volume_icon")} />
    </button>
  );
};
