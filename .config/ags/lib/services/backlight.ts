import { monitorFile, readFile } from "ags/file";
import GObject, { getter, register, setter } from "ags/gobject";
import { exec } from "ags/process";

const screen = exec('sh -c "ls -w1 /sys/class/backlight | head -1"');

@register({ GTypeName: "Backlight" })
export default class Backlight extends GObject.Object {
  static instance: Backlight;
  static get_default() {
    if (!this.instance) this.instance = new Backlight();
    return this.instance;
  }

  #maxBrightness = Number(exec(["brightnessctl", "m"]));
  #brightness = Number(exec(["brightnessctl", "g"])) / this.#maxBrightness;
  #brightnessIcon = "display-brightness-off-symbolic";

  @getter(Number)
  get brightness() {
    return this.#brightness;
  }

  @getter(String)
  get brightnessIcon() {
    return this.#brightnessIcon;
  }

  private updateIcon() {
    if (this.#brightness <= 0) {
      this.#brightnessIcon = "display-brightness-off-symbolic";
    } else if (this.#brightness <= 0.33) {
      this.#brightnessIcon = "display-brightness-low-symbolic";
    } else if (this.#brightness <= 0.66) {
      this.#brightnessIcon = "display-brightness-medium-symbolic";
    } else {
      this.#brightnessIcon = "display-brightness-high-symbolic";
    }
  }

  @setter(Number)
  set brightness(percent: number) {
    if (percent < 0) percent = 0;
    if (percent > 1) percent = 1;
    exec(`brightnessctl set ${percent * 100}%`);
    this.#brightness = percent;
    this.notify("brightness");
    this.updateIcon();
    this.notify("brightness_icon");
  }

  constructor() {
    super();
    monitorFile(`/sys/class/backlight/${screen}/brightness`, f => {
      const newBrightness = Number(readFile(f)) / this.#maxBrightness;
      this.#brightness = newBrightness;
      this.notify("brightness");
      this.updateIcon();
      this.notify("brightness_icon");
    });
    this.updateIcon();
  }
}
