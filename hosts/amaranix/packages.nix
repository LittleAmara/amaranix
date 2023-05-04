{ pkgs, ... }:
let
  dev = with pkgs;
    [
      # Editor
      neovim
      tree-sitter
      ripgrep # Mandatory if i want to use live_grep of telescope (nvim)

      # Python
      python311
      python311Packages.pip
      pyright
      black
      poetry

      # C / C++
      gnumake
      gcc
      clang-tools
      cmake
      cmake-language-server
      man-pages
      man-pages-posix
      gdb

      # Java
      jdk17
      jetbrains.idea-ultimate
      maven

      # Nodejs
      nodejs

      # Go
      go
      gopls

      #Nix
      nixpkgs-fmt
      nil

      # Others
      git
      docker-compose
      pre-commit
    ];

  terminal_utils = with pkgs; [
    fish
    starship
    binutils
    wget
    tree
    psmisc
    bat
    fd
    fzf
    zoxide
    betterlockscreen
    jq
    (catppuccin-gtk.override {
      accents = [ "flamingo" "green" "lavender" "mauve" "peach" "pink" "rosewater" "sky" "teal" ];
      variant = "frappe";
      tweaks = [ "rimless" ];
    })
  ];

  desktop = with pkgs; [
    rofi
    nitrogen
    picom
    polybarFull
    firefox
    thunderbird
    kitty
    slack
    discord
    spotify
  ];
in
dev ++ terminal_utils ++ desktop
