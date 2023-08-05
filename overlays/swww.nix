# This overlay only exists because the version "v0.8.1" of swww has breaking
# changes and is not usable in its current state.
# It introduces swww "v0.7.3".
self: super:
let
  pkgs = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05.tar.gz";
      sha256 = "sha256:10wn0l08j9lgqcw8177nh2ljrnxdrpri7bp0g7nvrsn9rkawvlbf";
    })
    {
      system = "x86_64-linux";
    };
in
{
  swww = pkgs.swww;
}
