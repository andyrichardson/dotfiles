final: prev: 

with prev.vscode-utils;
{
  vscode-extensions = prev.vscode-extensions.overrideAttrs {
    emmanuelbeziat.vscode-great-icons = (buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "vscode-great-icons";
        publisher = "emmanuelbeziat";
        version = "2.1.64";
        sha256 = "sha256-qsL1vWiEAYeWkMDNSrr1yzg0QxroEQQeznoDL3Ujy/o=";
      };
      meta = {
        license = lib.licenses.mit;
      };
    });
  };
}
 