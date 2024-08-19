{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "${../configurations/rofi/config.rasi}";
  };
}
