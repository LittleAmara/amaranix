let
  mkOverlay = (name: file: (self: super: {
    "${name}" = super.callPackage file { inherit (super); };
  }));
in
[
  #(import ./sf-mono.nix)
  (mkOverlay "sf-mono" ./sf-mono.nix)
]
