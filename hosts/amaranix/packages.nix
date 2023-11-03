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
      bear
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

      # Go
      go
      gopls

      #Nix
      nixpkgs-fmt
      nil

      # Rust
      rustup

      # Lua
      lua-language-server

      # Js
      nodejs_20

      # Hyprland
      pavucontrol
      xdg-utils
      grim
      slurp
      wl-clipboard
      networkmanagerapplet
      catppuccin-cursors
      dunst
      swww
      wofi
      pipewire
      wireplumber
      brightnessctl
      swaylock
      (waybar.overrideAttrs
        (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        }))

      # Others
      git
      docker-compose
      pre-commit
      virt-manager
      qemu
      virtiofsd
      postgresql
      kubectl
      kubectx
    ];

  terminal_utils = with pkgs; [
    htop
    starship
    binutils
    wget
    tree
    psmisc
    bat
    fd
    fzf
    zoxide
    jq
    (catppuccin-gtk.override {
      accents = [ "lavender" ];
      variant = "frappe";
      tweaks = [ "rimless" ];
    })
    tmux
    zip
    unzip
  ];

  desktop = with pkgs; [
    rofi-wayland-unwrapped
    firefox
    thunderbird
    kitty
    slack
    discord
    spotify
    zathura
  ];
in
dev ++ terminal_utils ++ desktop
