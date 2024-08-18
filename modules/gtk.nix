{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-peach-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "peach" ];
        variant = "mocha";
        tweaks = [ ];
      };
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    iconTheme = {
      name = "Colloid-dark";
      package = pkgs.colloid-icon-theme;
    };
    # gtk3.extraCss = ''
    #   .window-frame {
    #       box-shadow: none;
    #       margin: 0;
    #   }
    # '';
    # gtk4.extraCss = ''
    #   .window-frame {
    #       box-shadow: none;
    #       margin: 0;
    #   }
    # '';
  };
}
