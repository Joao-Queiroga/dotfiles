export function compileCss(): string {
  const scss = `${App.configDir}/style/style.scss`;
  const css = "/tmp/ags/style.css";
  Utils.exec(`sassc ${scss} ${css}`);
  return css;
}

export function reapplyCss() {
  App.resetCss();
  App.applyCss(compileCss());
}
