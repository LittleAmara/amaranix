{ inputs, system, lib, pkgs, ... }:

lib.nixosSystem {
  specialArgs = { inherit inputs system pkgs; };

  modules = [
    ./amaranix
  ];
}
