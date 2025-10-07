{inputs, ...}: {
  imports = [inputs.nixCats.homeModule];
  nixCats = {
    enable = true;
    luaPath = ./.;
    packageNames = ["nvim"];
    categoryDefinitions.replace = (
      {
        pkgs,
        settings,
        categories,
        ...
      } @ packageDef: {
        lspsAndRuntimeDeps = {
          general = with pkgs; [lazygit];
          lsp = with pkgs; [
            rust-analyzer
            gopls
            jdt-language-server
            clang-tools
            emmet-language-server
            typescript
            vscode-json-languageserver
            vscode-css-languageserver
            yaml-language-server
            nil
          ];
          format = with pkgs; [
            stylua
            alejandra
            prettierd
            google-java-format
            go
            taplo
          ];
          lint = with pkgs; [
            ruff
            selene
            clippy
            eslint
            checkstyle
          ];
          lua = with pkgs; [
            lua-language-server
            stylua
            selene
          ];
        };
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            lze
            lzextras
            nvim-treesitter.withAllGrammars
            tokyonight-nvim
          ];
        };
        optionalPlugins = {
          general = with pkgs.vimPlugins; [
            vim-tmux-navigator
            blink-cmp
            friendly-snippets
            colorful-menu-nvim
            ultimate-autopair-nvim
            nvim-lspconfig
            conform-nvim
            nvim-lint
            vim-startuptime
            lualine-nvim
            bufferline-nvim
            noice-nvim
            dropbar-nvim
            mini-nvim
            snacks-nvim
            trouble-nvim
            vim-illuminate
            rainbow-delimiters-nvim
            nvim-ts-autotag
            nvim-ts-context-commentstring
            which-key-nvim
          ];
          lsp = with pkgs.vimPlugins; [
            nvim-jdtls
            rustaceanvim
            crates-nvim
            typescript-tools-nvim
          ];
          lua = with pkgs.vimPlugins; [
            lazydev-nvim
            luvit-meta
          ];
        };
      }
    );
    packageDefinitions.replace = {
      nvim = {
        pkgs,
        name,
        ...
      }: {
        settings = {
          wrapRc = true;
          aliases = [
            "vim"
            "vi"
          ];
        };
        categories = {
          general = true;
          lsp = true;
          lua = true;
          format = true;
          lint = true;
        };
      };
    };
  };
}
