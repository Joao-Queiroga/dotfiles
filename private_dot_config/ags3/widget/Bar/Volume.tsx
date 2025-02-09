import { bind } from "astal"
import Wp from "gi://AstalWp";

export default function Volume() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!
  return <button className="volume"
    tooltipMarkup={bind(speaker, "volume").as(vol => `${Math.floor(vol * 100)}%`)}
    onClick={() => speaker.set_mute(!speaker.get_mute)} >
    <icon icon={bind(speaker, "volumeIcon")} />
  </button>
}
