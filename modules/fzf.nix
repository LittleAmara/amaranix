{ config, pkgs, lib, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = ''
      fd --color=always --type f --strip-cwd-prefix --hidden --exclude .git
    '';
    defaultOptions = [
      "--layout=reverse"
      "--height=75%"
      "-m"
      "--ansi"
      ''--bind="ctrl-space:toggle-preview"''
      "--preview='bat --color=always {}'"
      "--preview-window=:hidden"
    ];
    colors = {
      "bg+" = "#414559";
      bg = "#303446";
      spinner = "#f2d5cf";
      hl = "#e78284";
      fg = "#c6d0f5";
      header = "#e78284";
      info = "#ca9ee6";
      pointer = "#f2d5cf";
      marker = "#f2d5cf";
      "fg+" = "#c6d0f5";
      prompt = "#ca9ee6";
      "hl+" = "#e78284";
    };
  };
}
