{ config, pkgs, lib, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin-frappe";
    };
    themes = {
      catppuccin-frappe = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "master";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-mocha.tmTheme";
      };
    };
  };
}
