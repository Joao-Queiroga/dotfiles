import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";

const volumeIndicator = () =>
  Widget.Button({
    on_clicked: () => {
      if (Audio.speaker)
        Audio.speaker.stream.change_is_muted(!Audio.speaker.stream.is_muted);
    },
    class_name: "volume-indicator",

    child: Widget.Icon({ class_names: ["icon"] }).hook(
      Audio,
      (self) => {
        if (!Audio.speaker) return;
        const speaker = Audio.speaker;

        const vol = speaker.volume * 100;
        const icon = speaker.stream.isMuted
          ? "muted"
          : [
              [101, "overamplified"],
              [67, "high"],
              [34, "medium"],
              [1, "low"],
            ].find(([threshold]) => Number(threshold) <= vol)?.[1];

        self.icon = `audio-volume-${icon}-symbolic`;
        self.tooltipText = `Volume ${Math.floor(vol)}%${
          speaker.stream.isMuted ? "M" : ""
        }`;
      },
      "speaker-changed",
    ),
  });

export default volumeIndicator;
