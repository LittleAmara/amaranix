{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
    };
    shellAliases = {
      vim = "nvim";
      sshgit = "eval $(ssh-agent) && ssh-add";
      ls = "ls --color=always";
      gcd = "cd $(git rev-parse --show-toplevel)";
      k = "kubectl";
      kcx = "kubectx";
      kns = "kubens";
    };
    sessionVariables = {
      DISABLE_MAGIC_FUNCTIONS = true;
      SHELL = "zsh";
      MANROFFOPT = "-c";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      CLICOLOR = 1;
      NODE_PATH = "~/.npm-packages/lib/node_modules";
      EDITOR = "nvim";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./../configurations/p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "cf318e06a9b7c9f2219d78f41b46fa6e06011fd9";
          sha256 = "RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
        };
        file = "fast-syntax-highlighting.plugin.zsh";
      }
    ];
  };

  # Use the following command to setup the right colors on a new installation:
  # -> fast-theme XDG:catppuccin-mocha
  home.file = {
    ".config/fsh/catppuccin-mocha.ini".source = pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "zsh-fsh";
        rev = "7cdab58bddafe0565f84f6eaf2d7dd109bd6fc18";
        sha256 = "31lh+LpXGe7BMZBhRWvvbOTkwjOM77FPNaGy6d26hIA=";
      } + "/themes/catppuccin-mocha.ini";
  };
}
