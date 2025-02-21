{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    prefix = "C-s";
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = ''
      set -ag terminal-overrides ",$TERM:RGB"
      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # Use vim-style copy mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      set -g status-style bg=default
      set -g status-right '#[fg=color249]#(date +"%I:%M%p %m-%d-%Y")#[default]'
    '';
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
  };
}
