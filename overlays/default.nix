let
  mkOverlay = (name: file: (self: super: {
    "${name}" = super.callPackage file { inherit (super); };
  }));
in
[
  (mkOverlay "sf-mono" ./sf-mono.nix)
]
