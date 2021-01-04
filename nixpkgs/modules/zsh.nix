flakes: { config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "npm"
        "gitfast"
        "autojump"
      ];
      theme = "agnoster";
    };
    plugins = [
      {
        name = "antigen";
        file = "node-path.zsh";
        src = flakes.zsh-node-path;
      }
    ];
    initExtra = ''
      ## "initExtra" in zsh.nix
      # # Setup plugins
      # antigen bundle unixorn/autoupdate-antigen.zshplugin
      # antigen bundle zsh-users/zsh-completions
      # antigen bundle zsh-users/zsh-autosuggestions
      # antigen bundle zsh-users/zsh-syntax-highlighting
      # antigen bundle chrissicool/zsh-256color
      # antigen bundle amstrad/oh-my-matrix
      # antigen bundle lukechilds/zsh-nvm
      # antigen bundle lukechilds/zsh-better-npm-completion
      # antigen bundle andyrichardson/zsh-node-path
      # antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
      # antigen apply
    '';
  };
}

