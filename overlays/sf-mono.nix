{ pkgs }:

pkgs.stdenv.mkDerivation
rec {
  pname = "sf-mono";
  version = "1";

  mono = builtins.fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    sha256 = "sha256:0vjdpl3xyxl2rmfrnjsxpxdizpdr4canqa1nm63s5d3djs01iad6";
  };


  nativeBuildInputs = [ pkgs.p7zip ];

  sourceRoot = ".";

  dontUnpack = true;

  installPhase = ''
    7z x ${mono}
    cd SFMonoFonts
    7z x 'SF Mono Fonts.pkg'
    7z x 'Payload~'
    mkdir -p $out/fontfiles
    mv Library/Fonts/* $out/fontfiles
    cd ..

    mkdir -p $out/fonts/OTF
    mv $out/fontfiles/*.otf $out/fonts/OTF

    install -D -m444 -t $out/share/fonts/opentype $out/fonts/OTF/*.otf
    runHook postInstall
  '';
}
