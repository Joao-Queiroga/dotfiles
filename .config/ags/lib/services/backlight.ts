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

  @getter(Number)
  get brightness() {
    return this.#brightness;
  }

  @setter(Number)
  set brightness(percent: number) {
    if (percent < 0) percent = 0;
    if (percent > 1) percent = 1;

    this.#pendingBrightness = percent;
    const apply = async () => {
      if (this.#lock) {
        return;
      }
      this.#lock = true;

      const current = this.#pendingBrightness;
      await writeFileAsync(
        `/sys/class/backlight/ddcci6/brightness`,
        Math.floor(current * this.#maxBrightness).toString(),
      );

      this.#brightness = current;
      this.notify("brightness");
      this.#lock = false;
      if (this.#pendingBrightness !== current) apply();
    };

    apply();
  }

  constructor() {
    super();
    monitorFile(`/sys/class/backlight/${screen}/brightness`, async f => {
      if (this.#lock) return;
      const v = readFileAsync(f);
      const newBrightness = Number(v) / this.#maxBrightness;
      if (newBrightness !== this.#brightness) {
        this.#brightness = newBrightness;
        this.notify("brightness");
      }
    });
  }
}
