import GObject, { getter, register, setter } from "ags/gobject";
import { exec, execAsync } from "ags/process";
import { readFile, readFileAsync, writeFileAsync, monitorFile } from "ags/file";

const screen = exec(`sh -c "ls -w1 /sys/class/backlight | head -1"`);

@register({ GTypeName: "Backlight" })
export default class Backlight extends GObject.Object {
  static instance: Backlight;
  static get_default() {
    if (!this.instance) this.instance = new Backlight();
    return this.instance;
  }

  #maxBrightness = Number(readFile(`/sys/class/backlight/${screen}/max_brightness`));
  #brightness = Number(readFile(`/sys/class/backlight/${screen}/brightness`)) / this.#maxBrightness;
  #lock = false;
  #pendingBrightness = this.#brightness;
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

    this.#pendingBrightness = percent;
    if (this.#lock) return;
    // this.#lock = true;

    const current = this.#pendingBrightness;
    execAsync(`brightnessctl set ${percent * 100}%`)
      .catch(e => print("erro ao alterar brilho:", e))
      .then(() => {
        this.#brightness = current;
        this.notify("brightness");
        this.updateIcon();
        this.notify("brightness_icon");
        this.#lock = false;
        if (this.#pendingBrightness !== current) apply();
      });
  }

  constructor() {
    super();
    monitorFile(`/sys/class/backlight/${screen}/brightness`, f => {
      if (this.#lock) return;
      readFileAsync(f).then(v => {
        const newBrightness = Number(v) / this.#maxBrightness;
        if (newBrightness !== this.#brightness) {
          this.#brightness = newBrightness;
          this.notify("brightness");
          this.updateIcon();
          this.notify("brightness_icon");
        }
      });
    });
    this.updateIcon();
  }
}
