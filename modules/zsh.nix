{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh.enable = true;
    shellAliases = {
      vim = "nvim";
      sshgit = "eval $(ssh-agent) && ssh-add";
      ls = "ls --color=always";
      gcd = "cd $(git rev-parse --show-toplevel)";
    };
    sessionVariables = {
      DISABLE_MAGIC_FUNCTIONS = true;
      SHELL = "${pkgs.zsh}";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./../p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}
