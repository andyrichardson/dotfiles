{ config, pkgs, ... }:

with import ../config/secrets.nix;

{
  programs.git = {
    enable = true;
    userName = "Andy Richardson";
    userEmail = email;
    signing = {
      key = null;
      signByDefault = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GITHUB_TOKEN = githubToken;
  };
}
