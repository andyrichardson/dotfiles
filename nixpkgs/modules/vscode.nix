with (import <nixpkgs> {});
with import ../colors.nix;
flakes: { config, pkgs, lib, ... }:

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
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "python";
          publisher = "ms-python";
          version = "2020.12.424452561";
          sha256 = "sha256-ji5MS4B6EMehah8mi5qbkP+snCoVQJC5Ss2SG1XjoH0=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
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
          license = stdenv.lib.licenses.mit;
        };
      })
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vscode-styled-components";
          publisher = "jpoissonnier";
          version = "1.4.1";
          sha256 = "sha256-ojbeuYBCS+DjF5R0aLuBImzoSOb8mXw1s0Uh0CzggzE=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
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
          license = stdenv.lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "code-spell-checker";
          publisher = "streetsidesoftware";
          version = "1.10.2";
          sha256 = "sha256-K8pcjjy9cPEvjsz3avFf4pmifJm4L0uSOMy34rIhgNI=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
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
          license = stdenv.lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vscode-eslint";
          publisher = "dbaeumer";
          version = "2.1.14";
          sha256 = "sha256-bVGmp871yu1Llr3uJ+CCosDsrxJtD4b1+CR+omMUfIQ=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
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
          license = stdenv.lib.licenses.mit;
        };
      })
      # TODO: Create contribution to nixpkgs
      (buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vscode-graphql";
          publisher = "GraphQL";
          version = "0.3.13";
          sha256 = "sha256-JjEefVHQUYidUsr8Ce/dh7hLDm21WkyS+2RwsXHoY04=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
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
          license = stdenv.lib.licenses.mit;
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
          license = stdenv.lib.licenses.mit;
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
          license = stdenv.lib.licenses.mit;
        };
      })
    ];
    userSettings = {
      atomKeymap.promptV3Features = true;
      cSpell.userWords = [
        "devtools"
        "formik"
        "substate"
        "unmount"
        "urql"
      ];
      "editor.alwaysShowStatus" = true;
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
      eslint.validate = [
        "javascript"
        "javascriptreact"
        "html"
        "typescriptreact"
      ];
      explorer.compactFolders = false;
      javascript.updateImportsOnFileMove.enabled = true;
      liveshare = {
        account = "andyrichardson";
      };
      prettier.useEditorConfig = false;
      typescript.updateImportsOnFileMove.enabled = true;
      window.zoomLevel = -1;
      "workbench.colorCustomizations" = {
        editor.background = "#ff0000";
      };
      workbench = {
        # colorTheme = "Material Theme Darker";
        colorTheme = "One Dark";
        colorCustomizations = {
          activityBar.background = "#ff00000";
          editor.background = "#ff0000";
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