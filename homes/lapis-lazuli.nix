{ config, pkgs, lib, ... }:

rec {

  imports = [
    ../modules/fzf.nix
    ../modules/zsh.nix
    ../modules/tmux.nix
    ../modules/zoxide.nix
  ];

  home = {
    username = "amara";
    homeDirectory = "/home/${home.username}";
  };

  home.packages = [
    pkgs.hello
    pkgs.cowsay
  ];

  home.file = {
    ".config/appolox/toto".source = pkgs.emptyFile;
  };


  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
