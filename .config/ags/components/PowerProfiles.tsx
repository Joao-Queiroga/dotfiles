import { createBinding, For } from "ags";
import AstalPowerProfiles from "gi://AstalPowerProfiles";

const powerprofiles = AstalPowerProfiles.get_default();

export const Buttons = () => (
  <box>
    {powerprofiles.get_profiles().map(profile => (
      <box>
        <button
          iconName={`power-profile-${profile.profile}-symbolic`}
          onClicked={() => powerprofiles.set_active_profile(profile.profile)}
          class={createBinding(powerprofiles, "activeProfile").as(p => (profile.profile === p ? "active" : ""))}
        />
      </box>
    ))}
  </box>
);
