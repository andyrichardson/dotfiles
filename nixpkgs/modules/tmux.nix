{ config, pkgs, ... }:

{
  # home.packages = [
    
  # ];

  programs.tmux = {
    enable = true;
    plugins = [
      # pkgs.tmuxPlugins.onedark-theme
      pkgs.tmuxPlugins.yank
      pkgs.tmuxPlugins.sessionist
    ];
    extraConfig = ''
      # Set default shell
      set-option -g default-shell ${pkgs.zsh}/bin/zsh

      # Allow mouse scrolling
      set -g mouse on

      # Change split keys
      bind "'" split-window -h -c '#{pane_current_path}'
      bind "\\" split-window -v -c '#{pane_current_path}'
      bind c new-window -c '#{pane_current_path}'

      # Change select pane (works in vim) 
      bind h "select-pane -L"
      bind k "select-pane -U"
      bind j "select-pane -D"
      bind l "select-pane -R"

      # Change close key
      unbind x
      bind q kill-pane

      # Copy paste selection
      setw -g mode-keys vi
      bind-key -T copy-mode-vi End send-keys -X end-of-line
      bind-key -T copy-mode-vi Home send-keys -X start-of-line

      # Add truecolor support
      set-option -sa terminal-overrides ",xterm-256color:Tc" 
    '';
  };
}