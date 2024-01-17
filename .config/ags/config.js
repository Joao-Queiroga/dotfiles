import App from "resource:///com/github/Aylur/ags/app.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const scss = App.configDir + "/style/style.scss";
const css = App.configDir + "/style.css";

exec(`sassc ${scss} ${css}`);

const entry = App.configDir + "/ts/main.ts";
const outdir = "/tmp/ags/js";

try {
  print(
    await execAsync([
      "bun",
      "build",
      entry,
      "--outdir",
      outdir,
      "--external",
      "resource://*",
      "--external",
      "gi://*",
    ]),
  );
} catch (error) {
  console.error(error);
}

const main = await import(`file://${outdir}/main.js`);

export default {
  ...main.default,
  ...(await import("./js/main.js")).default,
  style: css,
};
