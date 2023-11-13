{ config, pkgs, lib, ... }:

rec {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "amara";
  home.homeDirectory = "/home/${home.username}";


  home.packages = [
    pkgs.hello
    pkgs.cowsay
  ];

  home.file = {
    ".config/appolox/toto".source = ./home.nix;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      vim = "nvim";
      sshgit = "eval $(ssh-agent) && ssh-add";
      ls = "ls --color-always";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = ''
      fd --color=always --type f --strip-cwd-prefix --hidden --exclude .git
    '';
    defaultOptions = [
      "--layout=reverse"
      "--height=75%"
      "-m"
      "--ansi"
      ''--bind="ctrl-space:toggle-preview"''
      "--preview='bat --color=always {}'"
      "--preview-window=:hidden"
    ];
    colors = {
      "bg+" = "#414559";
      bg = "#303446";
      spinner = "#f2d5cf";
      hl = "#e78284";
      fg = "#c6d0f5";
      header = "#e78284";
      info = "#ca9ee6";
      pointer = "#f2d5cf";
      marker = "#f2d5cf";
      "fg+" = "#c6d0f5";
      prompt = "#ca9ee6";
      "hl+" = "#e78284";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}