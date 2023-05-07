{ inputs, config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot = {
    initrd.secrets = { "/crypto_keyfile.bin" = null; }; # Setup keyfile
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "amara"; # Define your hostname.
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

  # Xserver configuration
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = true;
        enableScreensaver = false;
        enableXfwm = false;
      };
    };
    displayManager = {
      defaultSession = "xfce+i3";
      autoLogin = {
        enable = true;
        user = "amara";
      };

    };
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
    };
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  virtualisation.docker.enable = true;

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
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amara = {
    isNormalUser = true;
    description = "amara";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Packages
  environment = {
    systemPackages = import ./packages.nix { inherit pkgs; };
    etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
  };
  nixpkgs.config.allowUnfree = true;

  # Nix configuration
  nix = {
    package = pkgs.nixVersions.nix_2_15;
    settings.experimental-features = [ "nix-command" "flakes" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=/etc/channels/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels" ];
  };
  programs.command-not-found.enable = false;

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code-symbols
    fira
    fira-code
    font-awesome
  ];

  system.autoUpgrade.enable = false;
  system.stateVersion = "22.05";
}
