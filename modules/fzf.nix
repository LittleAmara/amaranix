{ config, pkgs, lib, ... }:

let
  inherit (config.themes.mocha) colors;
in
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
      "bg+" = colors.surface0;
      bg = colors.base;
      spinner = colors.rosewater;
      hl = colors.red;
      fg = colors.text;
      header = colors.red;
      info = colors.mauve;
      pointer = colors.rosewater;
      marker = colors.rosewater;
      "fg+" = colors.text;
      prompt = colors.mauve;
      "hl+" = colors.red;
    };
  };
}
