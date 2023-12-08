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

  # services.xserver.videoDrivers = [ "modesetting" "nvidia"];
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
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "video" "wireshark" "ubridge" ];
  };
  users.groups.ubridge = { };

  # Packages
  environment = {
    systemPackages = import ./packages.nix { inherit pkgs; };
    etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
    pathsToLink = [ "/share" ]; # needed by postgresql
  };
  nixpkgs.config.allowUnfree = true;
  programs.fish.enable = true; # enable fish with completion

  # Nix configuration
  nix = {
    package = pkgs.nixVersions.nix_2_15;
    settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=/etc/channels/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels" ];
  };
  programs.command-not-found.enable = false;

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code-symbols
    fira
    fira-code
    font-awesome
    monaspace.woff
  ];

  fonts.fontconfig.localConf = ''
    <match target="scan">
      <test name="family" compare="contains">
        <string>Monaspace</string>
      </test>
      <edit name="spacing">
        <int>100</int>
      </edit>
    </match>
  '';
  security.pam.services.swaylock =
    {
      text = ''
        auth include login
      '';
    };

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  security.wrappers.ubridge = {
    source = "/run/current-system/sw/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "ubridge";
    permissions = "u+rx,g+rx,o+x";
  };

  programs.wireshark =
    {
      enable = true;
      package = pkgs.wireshark;
    };

  # To remove when hyprland will support nixos 24.05
  xdg.portal.config.common.default = "*";
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };


  programs.dconf.enable = true;
  system.autoUpgrade.enable = false;
  system.stateVersion = "22.05";
}
