{ config, pkgs, ... }:

with import ../config/secrets.nix;

{
  programs.git = {
    enable = true;
    userName = "andyrichardson";
    userEmail = email;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GITHUB_TOKEN = githubToken;
  };
}
