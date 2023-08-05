{
  description = "Amara nixos configuration";
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOs";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };
    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "Hyprland";
      ref = "main";
    };
  };

  outputs = { self, nixpkgs, hyprland, ... }@inputs:
    let
      system = "x86_64-linux";

      inherit (nixpkgs) lib;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = import ./overlays;
      };
    in
    {
      nixosConfigurations = import ./hosts { inherit inputs lib pkgs system; };
    };
}
