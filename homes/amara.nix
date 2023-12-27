{ config, pkgs, lib, ... }:
let

  mkImports = (modules:
    builtins.map
      (name: ./.. + "/modules/${name}.nix")
      modules);

in
rec {

  imports = mkImports [
    "themes"
    "fzf"
    "zsh"
    "fzf"
    "tmux"
    "zoxide"
    "bat"
    "rofi"
    "gtk"
  ];

  home = {
    username = "amara";
    homeDirectory = "/home/${home.username}";
  };

  fonts.fontconfig.enable = true;

  home.file = {
    ".config/appolox/toto".source = pkgs.emptyFile;
  };


  home.packages = with pkgs;[
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

    # font
    sf-mono

    playerctl
    xwaylandvideobridge
    chromium
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
    docker-compose
    pre-commit
    virt-manager
    qemu
    virtiofsd
    postgresql
    kubectl
    kubectx

    inetutils
    ubridge
    gns3-gui
    (gns3-server.overrideAttrs (oldAttrs: {
      postInstall = ''
        ${oldAttrs.postInstall}

        chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources
        chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources/init.sh
        chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources/run-cmd.sh
        chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources/bin
        chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources/bin/busybox
      '';
    }))
    htop
    binutils
    wget
    tree
    psmisc
    fd
    jq
    (catppuccin-gtk.override {
      accents = [ "lavender" ];
      variant = "frappe";
      tweaks = [ "rimless" ];
    })
    zip
    unzip
    thunderbird
    kitty
    slack
    discord
    spotify
    zathura
  ];

  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
