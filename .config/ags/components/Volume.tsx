import { createBinding } from "ags";
import AstalWp from "gi://AstalWp";

const { defaultSpeaker: speaker, defaultMicrophone: microphone } = AstalWp.get_default()!;

export const VolumeIcon = () => (
  <button
    class="volume-icon"
    tooltip_markup={createBinding(speaker, "volume")(vol => `${Math.floor(vol * 100)}%`)}
    onClicked={() => speaker.set_mute(!speaker.mute)}
    icon_name={createBinding(speaker, "volume_icon")}
  />
);

export const VolumeSlider = () => (
  <box>
    <VolumeIcon />
    <slider hexpand onChangeValue={self => speaker.set_volume(self.value)} value={createBinding(speaker, "volume")} />
  </box>
);

export const MicrophoneIcon = () => (
  <button
    class="microphone-icon"
    tooltip_markup={createBinding(microphone, "volume")(vol => `${Math.floor(vol * 100)}%`)}
    onClicked={() => microphone.set_mute(!microphone.mute)}
    icon_name={createBinding(microphone, "volumeIcon")}
  />
);

export const MicrophoneSlider = () => (
  <box>
    <MicrophoneIcon />
    <slider
      hexpand
      onChangeValue={self => microphone.set_volume(self.value)}
      value={createBinding(microphone, "volume")}
    />
  </box>
);
