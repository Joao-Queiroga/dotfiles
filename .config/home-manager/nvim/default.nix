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
            spring-boot-tools
            clang-tools
            emmet-language-server
            typescript
            vscode-json-languageserver
            vscode-css-languageserver
            yaml-language-server
            nil
            kdePackages.qtdeclarative
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
            mini-nvim
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
            vim-startuptime
            heirline-nvim
            noice-nvim
            dropbar-nvim
            markview-nvim
            vim-table-mode
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
            spring-boot-nvim
            rustaceanvim
            crates-nvim
            typescript-tools-nvim
          ];
          lua = with pkgs.vimPlugins; [
            lazydev-nvim
            luvit-meta
          ];
          format = with pkgs.vimPlugins; [
            conform-nvim
          ];
          lint = with pkgs.vimPlugins; [
            nvim-lint
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
          springJars = "${pkgs.spring-boot-tools}/share/vscode/extensions/extension/jars";
        };
      };
    };
  };
}
