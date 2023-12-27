{ inputs, system, lib, pkgs, ... }:

lib.nixosSystem {
  specialArgs = { inherit inputs system pkgs; };

  modules = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
