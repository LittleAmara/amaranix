{ lib, pkgs, system, ... }:
{
  amaranix = import ./amara-laptop.nix { inherit system lib pkgs; };
}
