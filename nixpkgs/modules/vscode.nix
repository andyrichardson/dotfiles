with (import <nixpkgs> {});
flakes: { config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.bbenoist.Nix
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "theme-onedark";
        vscodeExtUniqueId = "akamud.vscode-theme-onedark";
        src = flakes.vscode-theme-onedark;
      })
      # (pkgs.vscode-utils.buildVscodeExtension {
      #   name = "spell-checker";
      #   vscodeExtUniqueId = "streetsidesoftware.code-spell-checker";
      #   src = flakes.vscode-spell-checker;
      #   buildInputs = [
      #     pkgs.nodejs
      #   ];
      #   buildPhase = ''
      #     export HOME=${placeholder "out"}/.npm
      #     npm ci --ignore-scripts
      #     npm ci --production
      #   '';
      # })
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "chrome-debugger";
        vscodeExtUniqueId = "msjsdiag.debugger-for-chrome";
        src = flakes.vscode-chrome-debugger;
        buildInputs = [
          pkgs.nodejs-10_x
          pkgs.python3
          (lib.optional stdenv.isDarwin [
            darwin.apple_sdk.frameworks.CoreServices
            darwin.apple_sdk.frameworks.AppKit
            darwin.apple_sdk.frameworks.Foundation
          ])
        ];
        buildPhase = ''
          # Setup (cache dir)
          export HOME=/tmp/nix-home
          
          # Build
          npm ci
          npm run build

          # Cleanup
          npm ci --ignore-scripts --production
          rm -rf $HOME
        '';
      })
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "docker";
        vscodeExtUniqueId = "ms-azuretools.vscode-docker";
        src = flakes.vscode-docker;
        buildInputs = lib.flatten [
          pkgs.nodejs 
          pkgs.python3
          (lib.optional stdenv.isDarwin [
            darwin.apple_sdk.frameworks.CoreServices
            darwin.apple_sdk.frameworks.AppKit
          ])
        ];
        buildPhase = ''
          # Setup (cache dir)
          export HOME=/tmp/nix-home
          
          # Build (w/ postinstall)
          npm ci

          # Cleanup
          npm ci --ignore-scripts --production
          rm -rf $HOME
        '';
      })
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "dotenv";
        vscodeExtUniqueId = "mikestead.dotenv";
        src = flakes.vscode-dotenv;
      })
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "eslint";
        vscodeExtUniqueId = "dbaeumer.vscode-eslint";
        src = flakes.vscode-eslint;
        buildInputs = lib.flatten [
          pkgs.nodejs 
        ];
        buildPhase = ''
          # Setup (cache dir)
          export HOME=/tmp/nix-home
          
          # Build (w/ postinstall)
          npm ci
          npm run webpack

          # Cleanup
          npm ci --ignore-scripts --production
          rm -rf $HOME
        '';
      })
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "atom-keybindings";
        vscodeExtUniqueId = "ms-vscode.atom-keybindings";
        src = flakes.vscode-atom-keybindings;
      })
      (pkgs.vscode-utils.buildVscodeExtension {
        name = "gitlens";
        vscodeExtUniqueId = "eamodio.gitlens";
        src = flakes.vscode-gitlens;
        buildInputs = lib.flatten [
          pkgs.nodejs 
        ];
        buildPhase = ''
          # Setup (cache dir)
          export HOME=/tmp/nix-home
          
          # Build (w/ postinstall)
          npx yarn --frozen-lockfile
          npm run bundle

          # Cleanup
          npx yarn --frozen-lockfile --production
          rm -rf $HOME
        '';
      })
      # (pkgs.vscode-utils.buildVscodeExtension {
      #   name = "graphql";
      #   vscodeExtUniqueId = "kumar-harsh.graphql-for-vscode";
      #   src = flakes.vscode-graphql;
      # })
      # (pkgs.vscode-utils.buildVscodeExtension {
      #   name = "terraform";
      #   vscodeExtUniqueId = "hashicorp.terraform";
      #   src = flakes.vscode-terraform;
      # })
      # (pkgs.vscode-utils.buildVscodeExtension {
      #   name = "live-share";
      #   vscodeExtUniqueId = "ms-vsliveshare.vsliveshare-pack";
      #   src = flakes.vscode-live-share;
      # })
    ];
  };
}