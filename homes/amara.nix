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

    # Nix
    nixpkgs-fmt
    nil

    # Rust
    rustup

    # Lua
    lua-language-server

    # Js
    nodejs
    nodePackages_latest.typescript-language-server

    # Java
    # jetbrains-toolbox
    # maven
    # jetbrains.idea-ultimate
    # jetbrains.jdk

    # Kubernetes
    kubectl
    kubectx

    # Terminal and terminal utils
    kitty
    htop
    binutils
    wget
    tree
    psmisc
    fd
    jq
    zip
    unzip

    # Font
    sf-mono

    # Audio and Music
    playerctl
    spotify
    pavucontrol

    # Browser
    chromium
    google-chrome

    # Wayland utils
    # xwaylandvideobridge
    # xdg-utils
    # grim
    # slurp
    # wl-clipboard
    # networkmanagerapplet
    # dunst
    # swww
    # hyprpaper
    # brightnessctl
    # swaylock
    # waybar

    # Social
    thunderbird
    slack
    discord

    # Themes
    (catppuccin-gtk.override {
      accents = [ "lavender" ];
      variant = "frappe";
      tweaks = [ "rimless" ];
    })
    catppuccin-cursors


    # Miscellaneous
    nitrogen
    betterlockscreen
    brightnessctl
    fswatch
    ansible
    docker-compose
    pre-commit
    virt-manager
    qemu
    virtiofsd
    postgresql
    inetutils
    ubridge
    postman
    # gns3-gui
    # (gns3-server.overrideAttrs (oldAttrs: {
    #   postInstall = ''
    #     ${oldAttrs.postInstall}

    #     chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources
    #     chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources/init.sh
    #     chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources/run-cmd.sh
    #     chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources/bin
    #     chmod +x $out/lib/python3.11/site-packages/gns3server/compute/docker/resources/bin/busybox
    #   '';
    # }))
  ];

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
