{
  description = "Amara nixos configuration";
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOs";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    neovim-nightly = {
      type = "github";
      owner = "nix-community";
      repo = "neovim-nightly-overlay";
      ref = "master";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, neovim-nightly, ... }@inputs:
    let
      system = "x86_64-linux";

      inherit (nixpkgs) lib;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = import ./overlays ++ [ inputs.neovim-nightly.overlays.default ];
      };
    in
    {
      nixosConfigurations = import ./hosts { inherit inputs lib pkgs system; };
      homeConfigurations = import ./homes { inherit inputs lib pkgs; };
    };
}
