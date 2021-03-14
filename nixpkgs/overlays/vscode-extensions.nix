final: prev: 

with prev.vscode-utils;
{
  prev.lib.trace = "Hello";
  vscode-extensions = prev.lib.mkMerge [
    prev.vscode-extensions
    {
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
    }
  ];
}
 