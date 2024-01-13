import App from "resource:///com/github/Aylur/ags/app.js";
import { exec } from "resource:///com/github/Aylur/ags/utils.js";

const scss = App.configDir + "/style/style.scss";
const css = App.configDir + "/style.css";

exec(`sassc ${scss} ${css}`);

export default {
  ...(await import("./js/main.js")).default,
  style: css,
};
