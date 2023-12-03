{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    theme = "${../configurations/rofi/config.rasi}";
  };
}
