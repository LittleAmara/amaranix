{ inputs, system, lib, pkgs, ... }:

lib.nixosSystem {
  specialArgs = { inherit inputs system pkgs; };

  modules = [
    inputs.hyprland.nixosModules.default
    {
      programs.hyprland = {
        enable = true;
        nvidiaPatches = true;
      };
    }

    ./amaranix
  ];
}
