{system, lib, pkgs, ...}:

lib.nixosSystem {
  inherit system pkgs;

  modules = [
    ./amaranix
  ];
}
