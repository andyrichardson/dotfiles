flakes: { config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "npm"
        "git"
        "autojump"
      ];
    };
    initExtra = ''
      source ~/.p10k.zsh
    '';
    plugins = [
      {
        name = "node-path";
        file = "node-path.zsh";
        src = flakes.zsh-node-path;
      }
      {
        name = "zsh-completions";
        file = "zsh-completions.plugin.zsh";
        src = flakes.zsh-completions;
      }
      {
        name = "zsh-autosuggestions";
        file = "zsh-autosuggestions.plugin.zsh";
        src = flakes.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.plugin.zsh";
        src = flakes.zsh-syntax-highlighting;
      }
      {
        name = "zsh-256color";
        file = "zsh-256color.plugin.zsh";
        src = flakes.zsh-256color;
      }
      {
        name = "zsh-nvm";
        file = "zsh-nvm.plugin.zsh";
        src = flakes.zsh-nvm;
      }
      {
        name = "zsh-better-npm-completion";
        file = "zsh-better-npm-completion.plugin.zsh";
        src = flakes.zsh-better-npm-completion;
      }
      {
        name = "zsh-autoswitch-virtualenv";
        file = "zsh-autoswitch-virtualenv.plugin.zsh";
        src = flakes.zsh-autoswitch-virtualenv;
      }
      {
      name = "zsh-powerline-powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = flakes.zsh-powerline;
      }
    ];
  };

  # P10k (powerline) config
  home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;
}

