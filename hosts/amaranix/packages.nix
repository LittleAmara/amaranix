{ pkgs, ... }:
let
  dev = with pkgs;
    [
      # Hyprland
    ];

  terminal_utils = with pkgs; [
  ];

  desktop = with pkgs; [
    #rofi-wayland-unwrapped
  ];
in
dev ++ terminal_utils ++ desktop
