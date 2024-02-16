import Widget from "resource:///com/github/Aylur/ags/widget.js";
import VolumeProgress from "./Modules/volume";

export default () =>
  Widget.Box({
    children: [VolumeProgress()],
  });
