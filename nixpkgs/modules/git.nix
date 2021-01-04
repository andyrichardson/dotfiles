flakes: { config, pkgs, ... }:

with import ../secrets.nix;

{
  programs.git = {
    enable = true;
    userName = "Test Richardson";
    userEmail = email;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GITHUB_TOKEN = githubToken;
  };
}