with import ../config/colors.nix;
{ config, pkgs, lib, ... }:

{
  xdg.configFile."Code/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dev/dotfiles/nix/config/settings.json";
  programs.vscode = {
    enable = true;
    package = pkgs.vscode; # Nonfree
    extensions = with pkgs.vscode-extensions;
      with pkgs.vscode-utils; [
        bbenoist.Nix
        ms-azuretools.vscode-docker
        pkief.material-icon-theme
        mskelton.one-dark-theme
        esbenp.prettier-vscode
        msjsdiag.debugger-for-chrome
        graphql.vscode-graphql
        eamodio.gitlens
        jpoissonnier.vscode-styled-components
        mikestead.dotenv
        dbaeumer.vscode-eslint
        streetsidesoftware.code-spell-checker
        eamodio.gitlens
        (buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "vsliveshare-pack";
            publisher = "ms-vsliveshare";
            version = "0.4.0";
            sha256 = "sha256-xTdfOqdypAaWpmtYIM0H7gwCy1jXNl5+HarvVW/3AiY=";
          };
          meta = { license = lib.licenses.mit; };
        })
        # TODO: Create contribution to nixpkgs 
        (buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "vscode-great-icons";
            publisher = "emmanuelbeziat";
            version = "2.1.64";
            sha256 = "sha256-qsL1vWiEAYeWkMDNSrr1yzg0QxroEQQeznoDL3Ujy/o=";
          };
          meta = { license = lib.licenses.mit; };
        })
        # TODO: Create contribution to nixpkgs
        (buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "atom-keybindings";
            publisher = "ms-vscode";
            version = "3.0.9";
            sha256 = "sha256-Qey75Irpb3Y+Unbf+ppTTVoU3XGAVJD8oXN5XKJhWBI=";
          };
          meta = { license = lib.licenses.mit; };
        })
        # TODO: Create contribution to nixpkgs
        (buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "terraform";
            publisher = "HashiCorp";
            version = "2.3.0";
            sha256 = "sha256-GJv6zSEwv6aAgyz8h8JHKdMjOV77lyQQwGVNky3CJhk=";
          };
          meta = { license = lib.licenses.mit; };
        })
        # TODO: Create contribution to nixpkgs
        (buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "markdown-preview-github-styles";
            publisher = "bierner";
            version = "0.1.6";
            sha256 = "sha256-POIrekEkrYVj7MU9ZXToLIV0pl2X8PUBOQuuB4Mykt4=";
          };
          meta = { license = lib.licenses.mit; };
        })
      ];
  };
}
