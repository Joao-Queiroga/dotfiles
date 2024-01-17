import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";

const volumeIndicator = () =>
  Widget.Button({
    onClicked: () => (Audio.speaker.isMuted = !Audio.speaker.isMuted),
    child: Widget.Icon().hook(
      Audio,
      (self) => {
        if (!Audio.speaker) return;

        const vol = Audio.speaker.volume * 100;
        const icon = [
          [101, "overamplified"],
          [67, "high"],
          [34, "medium"],
          [1, "low"],
          [0, "muted"],
        ].find(([threshold]) => threshold <= vol)[1];

        self.icon = `audio-volume-${icon}-symbolic`;
        self.tooltipText = `Volume ${Math.floor(vol)}%`;
      },
      "speaker-changed",
    ),
  });

export default volumeIndicator;
