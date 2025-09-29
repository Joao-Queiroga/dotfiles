{ config, pkgs, lib, inputs, ... }: {
  imports = [ inputs.nixCats.homeModule ];
  nixCats = {
    enable = true;
    luaPath = ./.;
    packageNames = [ "nvim" ];
    categoryDefinitions.replace =
      ({ pkgs, settings, categories, ... }@packagDef: {
        lspsAndRuntimeDeps = {
          general = with pkgs; [ lazygit ];
          lua = with pkgs; [ lua-language-server stylua selene ];
        };
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            lze
            lzextras
            snacks-nvim
            tokyonight-nvim
            mini-nvim
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
          ];
          lua = with pkgs.vimPlugins; [ lazydev-nvim ];
        };
      });
    packageDefinitions.replace = {
      nvim = { pkgs, name, ... }: {
        settings = {
          wrapRc = true;
          aliases = [ "vim" "vi" ];
        };
        categories = { general = true;
          lua = true;
        };
      };
    };
  };
}
