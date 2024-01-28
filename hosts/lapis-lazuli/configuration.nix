{ inputs, config, pkgs, ... }:

{
  # Bootloader
  boot = {
    initrd.secrets = { "/crypto_keyfile.bin" = null; }; # Setup keyfile
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  # Linux kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6;

  # Networking
  networking = {
    hostName = "lapis-lazuli";
    networkmanager.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.utf8";
      LC_IDENTIFICATION = "fr_FR.utf8";
      LC_MEASUREMENT = "fr_FR.utf8";
      LC_MONETARY = "fr_FR.utf8";
      LC_NAME = "fr_FR.utf8";
      LC_NUMERIC = "fr_FR.utf8";
      LC_PAPER = "fr_FR.utf8";
      LC_TELEPHONE = "fr_FR.utf8";
      LC_TIME = "fr_FR.utf8";
    };
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.opengl.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "terminate:ctrl_alt_bksp,compose:ralt";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amara = {
    isNormalUser = true;
    description = "amara";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "video" "wireshark" "ubridge" ];
  };
  users.groups.ubridge = { };

  # Environment
  environment = {
    systemPackages = with pkgs; [
      git
      vim
      curl
    ];
    etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
    pathsToLink = [ "/share" ]; # needed by postgresql
  };

  # Nix configuration
  nix = {
    package = pkgs.nixVersions.nix_2_15;
    settings = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [
      "nixpkgs=/etc/channels/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  # Virtualisation
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  # Security
  security = {
    wrappers.ubridge = {
      source = "/run/current-system/sw/bin/ubridge";
      capabilities = "cap_net_admin,cap_net_raw=ep";
      owner = "root";
      group = "ubridge";
      permissions = "u+rx,g+rx,o+x";
    };
    pam.services.swaylock =
      {
        text = ''
          auth include login
        '';
      };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Misc
  services.logind.powerKey = "ignore";
  programs = {
    command-not-found.enable = false;
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    dconf.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code-symbols
    fira
    fira-code
    font-awesome
  ];
  system.autoUpgrade.enable = false;
  system.stateVersion = "22.05";
}
