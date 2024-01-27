{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
    keyMode = "vi";
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
    terminal = "tmux-256color";
    extraConfig = ''
      # Catppuccin colors
      cat_bg="#303446"
      cat_fg="#c6d0f5"
      cat_cyan="#99d1db"
      cat_black="#292c3c"
      cat_gray="#414559"
      cat_magenta="#ca9ee6"
      cat_pink="#f4b8e4"
      cat_red="#e78284"
      cat_green="#a6d189"
      cat_yellow="#e5c890"
      cat_blue="#8caaee"
      cat_orange="#ef9f76"
      cat_black4="#626880"
      cat_flamingo="#eebebe"
      cat_mauve="#ca9ee6"
      cat_text="#c6d0f5"
      cat_crust="#232634"

      # Status bar
      set -g status-position "bottom"
      set -g status-style bg=default,fg=default
      set -g status-justify right
      set -g status-right "  "
      set -g status-left "#[bg=default,fg=default,bold]#{?client_prefix,,#S}#[bg=$cat_blue,fg=black,bold]#{?client_prefix,#S,}#[bg=default,fg=default,bold]  "
      set -g window-status-format " #I:#W "
      set -g window-status-current-format "#[bg=$cat_blue,fg=black,bold] #I:#W "
      set -g status-left-length '100'
      set -g status-right-length '100'

      # Vi-like keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Windows splitting
      unbind %
      bind | split-window -h
      unbind '"'
      bind _ split-window -v

      # Keybindings
      bind -n M-Enter new-window
      bind -n M-H previous-window
      bind -n M-L next-window

      bind -n M-0 select-window -t 0
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R


      # General options
      set -g pane-active-border-style fg=$cat_flamingo
    '';
  };
}
