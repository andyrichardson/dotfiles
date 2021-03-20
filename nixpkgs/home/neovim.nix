{ config, pkgs, inputs, ... }:

# https://github.com/nix-community/home-manager/issues/815#issuecomment-537442524
let
  loadPlugin = plugin: ''
    set rtp^=${plugin.rtp}
    set rtp+=${plugin.rtp}/after
  '';
  plugins = with pkgs.vimPlugins; [
    nerdtree
    pkgs.vimPlugins.vim-nix
    pkgs.vimPlugins.typescript-vim
    # (pkgs.vimUtils.buildVimPluginFrom2Nix {
    #    pname = "vim-prettier";
    #    version = "2020-12-22";
    #    src = pkgs.fetchFromGitHub {
    #      owner = "prettier";
    #      repo = "vim-prettier";
    #      rev = "671ca8bd00052cf011c2f276587c95a20557a014";
    #      sha256 = "0rq74znq9mx5p925jd120l5apjqdqp6xy6llzhf2gq5cxpg62hjl";
    #    };
    #    meta.homepage = "https://github.com/prettier/vim-prettier/";
    # })
  ];
in {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraConfig = ''
      " # Display
      set relativenumber
      set termguicolors
      syntax on
      
      ${builtins.concatStringsSep "\n"
            (map loadPlugin plugins)}

      " # Keymaps
      imap jj <Esc>
      map <C-N> :NERDTreeToggle<CR>
      map <A-N> :NERDTreeFocus<CR>
    '';


  };
}

