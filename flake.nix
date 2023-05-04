{
  description = "Amara nixos configuration";
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOs";
      repo = "nixpkgs";
      ref = "master";
    };
  };

  outputs = { self, nixpkgs, ... }@args:
    let
      inherit (nixpkgs) lib;

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = import ./hosts { inherit lib pkgs system; };
      packages = {nix = pkgs.nixVersions.nix_2_15;};
    };
}
