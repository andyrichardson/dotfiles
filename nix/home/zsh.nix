{ config, pkgs, inputs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "npm" "git" ];
    };
    initExtraBeforeCompInit = ''
      # Temporary for macOS - see https://github.com/nix-community/home-manager/issues/1782
      # . /Users/andyrichardson/.nix-profile/etc/profile.d/nix.sh
      # Temporary for macOS
      # . /etc/static/bashrc 
    '';
    initExtra = ''
      source ~/.p10k.zsh
      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down

      export NIX_BUILD_SHELL=zsh
      export NVM_LAZY_LOAD=true
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=red,fg=white,bold"
    '';

    plugins = [
      {
        name = "node-path";
        file = "node-path.zsh";
        src = inputs.zsh-node-path;
      }
      {
        name = "zsh-completions";
        file = "zsh-completions.plugin.zsh";
        src = inputs.zsh-completions;
      }
      {
        name = "zsh-autosuggestions";
        file = "zsh-autosuggestions.plugin.zsh";
        src = inputs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.plugin.zsh";
        src = inputs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-256color";
        file = "zsh-256color.plugin.zsh";
        src = inputs.zsh-256color;
      }
      {
        name = "zsh-nvm";
        file = "zsh-nvm.plugin.zsh";
        src = inputs.zsh-nvm;
      }
      {
        name = "zsh-better-npm-completion";
        file = "zsh-better-npm-completion.plugin.zsh";
        src = inputs.zsh-better-npm-completion;
      }
      {
        name = "zsh-autoswitch-virtualenv";
        file = "zsh-autoswitch-virtualenv.plugin.zsh";
        src = inputs.zsh-autoswitch-virtualenv;
      }
      {
        name = "zsh-powerline-powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = inputs.zsh-powerline;
      }
      {
        name = "zsh-history-substring-search";
        file = "zsh-history-substring-search.plugin.zsh";
        src = inputs.zsh-history-substring-search;
      }
    ];
  };
  programs.autojump.enable = true;

  # P10k (powerline) config
  home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;
}

