{ inputs, lib, pkgs, system, ... }:
{
  lapis-lazuli = import ./lapis-lazuli { inherit inputs system lib pkgs; };
}
