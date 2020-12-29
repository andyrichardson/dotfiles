{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.zsh
  ];

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
        name = "zsh-nix-shell";
        file = "antigen.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "antigen";
          rev = "v2.2.3";
          sha256 = "1hqnwdskdmaiyi1p63gg66hbxi1igxib6ql8db3w950kjs1cs7rq";
        };
      }
    ];
    initExtra = ''
      ## "initExtra" in zsh.nix
      # Setup plugins
      antigen bundle unixorn/autoupdate-antigen.zshplugin
      antigen bundle zsh-users/zsh-completions
      antigen bundle zsh-users/zsh-autosuggestions
      antigen bundle zsh-users/zsh-syntax-highlighting
      antigen bundle chrissicool/zsh-256color
      antigen bundle amstrad/oh-my-matrix
      antigen bundle lukechilds/zsh-nvm
      antigen bundle lukechilds/zsh-better-npm-completion
      antigen bundle andyrichardson/zsh-node-path
      antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
      antigen apply
    '';
  };
}

