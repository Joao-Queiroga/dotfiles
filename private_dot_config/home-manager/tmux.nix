{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    clock24 = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      yank
      {
        plugin = vim-tmux-navigator;
        extraConfig = "bind C-l send-keys 'C-l'";
      }
    ];
    terminal = "tmux-256color";
    extraConfig = ''
      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # keybinddings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Open panes in Cwd
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # image.nvim
      set -gq allow-passthrough on
      set -g visual-activity off
    '';
  };
}
