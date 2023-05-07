{ inputs, lib, pkgs, system, ... }:
{
  amaranix = import ./amara-laptop.nix { inherit inputs system lib pkgs; };
}
