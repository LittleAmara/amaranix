{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Standard-Peach-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "peach" ];
        variant = "frappe";
        tweaks = [ "rimless" ];
      };
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark-Cursors";
      package = pkgs.catppuccin-cursors.frappeDark;
    };
    iconTheme = {
      name = "Colloid-dark";
      package = pkgs.colloid-icon-theme;
    };
    gtk3.extraCss = ''
      .window-frame {
          box-shadow: none;
          margin: 0;
      }
    '';
    gtk4.extraCss = ''
      .window-frame {
          box-shadow: none;
          margin: 0;
      }
    '';
  };
}
