with import ../config/colors.nix;
{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; with pkgs.vscode-utils; [
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
          name = "python";
          publisher = "ms-python";
          version = "2020.12.424452561";
          sha256 = "sha256-ji5MS4B6EMehah8mi5qbkP+snCoVQJC5Ss2SG1XjoH0=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # (lib.optional stdenv.isLinux pkgs.vscode-extensions.ms-vsliveshare.vsliveshare)
      # (buildVscodeExtension {
      #   name = "theme-onedark";
      #   vscodeExtUniqueId = "akamud.vscode-theme-onedark";
      #   src = flakes.vscode-theme-onedark;
      # })
      # TODO: Create contribution to nixpkgs 
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vsliveshare-pack";
          publisher = "ms-vsliveshare";
          version = "0.4.0";
          sha256 = "sha256-xTdfOqdypAaWpmtYIM0H7gwCy1jXNl5+HarvVW/3AiY=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs 
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vscode-great-icons";
          publisher = "emmanuelbeziat";
          version = "2.1.64";
          sha256 = "sha256-qsL1vWiEAYeWkMDNSrr1yzg0QxroEQQeznoDL3Ujy/o=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs 
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vscode-styled-components";
          publisher = "jpoissonnier";
          version = "1.4.1";
          sha256 = "sha256-ojbeuYBCS+DjF5R0aLuBImzoSOb8mXw1s0Uh0CzggzE=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs 
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "python";
          publisher = "ms-python";
          version = "2020.12.424452561";
          sha256 = "sha256-ji5MS4B6EMehah8mi5qbkP+snCoVQJC5Ss2SG1XjoH0=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "dotenv";
          publisher = "mikestead";
          version = "1.0.1";
          sha256 = "sha256-dieCzNOIcZiTGu4Mv5zYlG7jLhaEsJR05qbzzzQ7RWc=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "atom-keybindings";
          publisher = "ms-vscode";
          version = "3.0.9";
          sha256 = "sha256-Qey75Irpb3Y+Unbf+ppTTVoU3XGAVJD8oXN5XKJhWBI=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "gitlens";
          publisher = "eamodio";
          version = "11.1.3";
          sha256 = "sha256-hqJg3jP4bbXU4qSJOjeKfjkPx61yPDMsQdSUVZObK/U=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "terraform";
          publisher = "HashiCorp";
          version = "2.3.0";
          sha256 = "sha256-GJv6zSEwv6aAgyz8h8JHKdMjOV77lyQQwGVNky3CJhk=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "markdown-preview-github-styles";
          publisher = "bierner";
          version = "0.1.6";
          sha256 = "sha256-POIrekEkrYVj7MU9ZXToLIV0pl2X8PUBOQuuB4Mykt4=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
    ];
    userSettings = {
      "atomKeymap.promptV3Features" = true;
      "cSpell.userWords" = [
        "devtools"
        "formik"
        "substate"
        "unmount"
        "urql"
      ];
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.detectIndentation" = false;
      "editor.fontFamily" = "'DejaVUSansMono Nerd Font', Monaco, Consolas, 'Courier New', Courier";
      "editor.fontSize" = 15;
      "editor.formatOnSave" = true;
      "editor.gotoLocation.multiple" = "goto";
      "editor.minimap.enabled" = false;
      "editor.multiCursorModifier" = "ctrlCmd";
      "editor.tabSize" = 2;
      "editor.tokenColorCustomizations" = {
        background = "#00ff00";
        editor.background = "#00ff00";
        comments = "#ff0000";
      };
      "eslint.validate" = [
        "javascript"
        "javascriptreact"
        "html"
        "typescriptreact"
      ];
      "explorer.compactFolders" = false;
      "javascript.updateImportsOnFileMove.enabled" = true;
      "liveshare.account" = "andyrichardson";
      "prettier.useEditorConfig" = false;
      "typescript.updateImportsOnFileMove.enabled" = true;
      "window.zoomLevel" = -1;
      "workbench.colorCustomizations" = {
        "editor.background" = background;
      };
      "workbench.fontAliasing" = "antialiased";
      "workbench.iconTheme" = "vscode-great-icons";
      workbench = {
        # colorTheme = "Material Theme Darker";
        colorTheme = "One Dark";
        colorCustomizations = {
          activityBar.background = "#ff00000";
          editor.background = background;
        };
        editor = {
          enablePreview = false;
          enablePreviewFromQuickOpen = false;
        };
        fontAliasing = "antialiased";
        iconTheme = "vscode-great-icons";
        startupEditor = "newUntitledFile";
      };
    };
  };
}
