// an example to create a new mapping `ctrl-y`
api.mapkey("<ctrl-y>", "Show me the money", function () {
  Front.showPopup(
    "a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).",
  );
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
api.map("gt", "T");

const switchKey = (keyA, keyB) => {
  api.map(">_t", keyA);
  api.map(keyA, keyB);
  api.map(keyB, keyA);
  api.unmap(">_t");
};

api.map("u", "e");
api.mapkey("p", "Open the clipboard's URL in the current tab", function () {
  Front.getContentFromClipboard(function (response) {
    window.location.href = "google.com";
  });
});
// map search keys
api.map(";og", "og");
api.map(";oy", "oy");

api.map("P", "cc");
api.map("gi", "i");
api.map("F", "gf");
api.map("gf", "w");
api.map("`", "'");
// save default key `t` to temp key `>_t`
api.map(">_t", "t");
// create a new key `t` for default key `on`
api.map("t", "on");
// create a new key `o` for saved temp key `>_t`
api.map("o", ">_t");
api.map("H", "S");
api.map("L", "D");
api.map("gt", "R");
api.map("gT", "E");
api.map("J", "R");
api.map("K", "E");
api.unmap("E");

// an example to remove mapkey `Ctrl-i`
api.unmap("<ctrl-i>");
api.unmap("s");
api.unmap("d");
api.unmap("D");

api.iunmap("Ctrl-a");
api.iunmap("Ctrl-e");

switchKey(";u", ";U");

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #1a1b26;
    color: #c0caf5;
}
.sk_theme tbody {
    color: #a9b1d6;
}
.sk_theme input {
    color: #a9b1d6;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #61afef;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #24283b;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #2e344e;
}
#sk_status, #sk_find {
    font-size: 20pt;
}
/* ace editor */
:root {
    --theme-ace-bg: #1a1b26ab; /* Observe o quarto canal, isso adiciona transparência */
    --theme-ace-bg-accent: #2e344e;
    --theme-ace-fg: #c0caf5;
    --theme-ace-fg-accent: #a9b1d6;
    --theme-ace-cursor: #61afef;
    --theme-ace-select: #61afef;
}
#sk_editor {
    height: 50% !important; /* Remova isso para restaurar o tamanho padrão do editor */
    background: var(--theme-ace-bg) !important;
}
.ace_dialog-bottom {
    border-top: 1px solid var(--theme-ace-bg) !important;
}
.ace-chrome .ace_print-margin, .ace_gutter, .ace_gutter-cell, .ace_dialog {
    background: var(--theme-ace-bg-accent) !important;
}
.ace-chrome {
    color: var(--theme-ace-fg) !important;
}
.ace_gutter, .ace_dialog {
    color: var(--theme-ace-fg-accent) !important;
}
.ace_cursor {
    color: var(--theme-ace-cursor) !important;
}
.normal-mode .ace_cursor {
    background-color: var(--theme-ace-cursor) !important;
    border: var(--theme-ace-cursor) !important;
}
.ace_marker-layer .ace_selection {
    background: var(--theme-ace-select) !important;
}
`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>
settings.scrollStepSize = 140;
