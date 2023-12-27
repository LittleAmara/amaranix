{ inputs, lib, pkgs, ... }:
let
  mkHome = modules:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs modules;
    };
in
{
  amara = mkHome [ ./amara.nix ];
}
