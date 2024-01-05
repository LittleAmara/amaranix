{ inputs, lib, pkgs, ... }:
let
  mkHome = modules:
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {
        inherit (inputs) hyprland;
      };
      inherit pkgs modules;
    };
in
{
  amara = mkHome [ ./amara.nix ];
}
