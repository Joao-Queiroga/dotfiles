const audio = await Service.import("audio");

const volumeIndicator = () =>
  Widget.Button({
    on_clicked: () => {
      if (audio.speaker)
        audio.speaker.stream?.change_is_muted(!audio.speaker.stream.is_muted);
    },
    class_name: "volume-indicator",

    child: Widget.Icon({ class_names: ["icon"] }).hook(
      audio,
      (self) => {
        if (!audio.speaker) return;
        const speaker = audio.speaker;

        const vol = speaker.volume * 100;
        const icon = speaker.stream?.isMuted
          ? "muted"
          : [
              [101, "overamplified"],
              [67, "high"],
              [34, "medium"],
              [1, "low"],
            ].find(([threshold]) => Number(threshold) <= vol)?.[1];

        self.icon = `audio-volume-${icon}-symbolic`;
        self.tooltip_text = `Volume ${Math.floor(vol)}%${
          speaker.stream?.isMuted ? "M" : ""
        }`;
      },
      "speaker-changed",
    ),
  });

export default volumeIndicator;
