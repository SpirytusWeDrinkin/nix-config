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
    escapeTime = 0;
    extraConfig = ''
      # Colors
      set -ag terminal-overrides ",$TERM:RGB"

      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      bind -r C-h resize-pane -L 1
      bind -r C-j resize-pane -D 1
      bind -r C-k resize-pane -U 1
      bind -r C-l resize-pane -R 1

      # Vi copy mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      # Catppuccin Macchiato borders
      set -g pane-border-style "fg=#8087a2"
      set -g pane-active-border-style "fg=#c6a0f6"

      # Catppuccin Macchiato messages
      set -g message-style "bg=default,fg=#ed8796"
      set -g message-command-style "bg=default,fg=#8bd5ca"

      # Catppuccin Macchiato copy mode (mauve selection)
      set -g mode-style "bg=#c6a0f6,fg=#181926"

      # Catppuccin Macchiato popup
      set -g popup-border-style "fg=#c6a0f6"
      set -g popup-border-lines rounded

      # Clock mode
      set -g clock-mode-colour "#c6a0f6"
    '';
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank

      # Open files and URLs from copy mode
      open

      # Extract and copy text with fzf
      {
        plugin = extrakto;
        extraConfig = ''
          set -g @extrakto_key 'tab'
          set -g @extrakto_grab_area 'window recent'
          set -g @extrakto_split_direction 'p'
          set -g @extrakto_split_size '15'
          set -g @extrakto_fzf_tool 'fzf'
        '';
      }

      # Fuzzy find URLs
      {
        plugin = fzf-tmux-url;
        extraConfig = ''
          set -g @fzf-url-bind 'u'
          set -g @fzf-url-fzf-options '-w 50% -h 50% --multi -0 --no-preview --no-border'
        '';
      }

      # Status bar theme
      {
        plugin = dotbar;
        extraConfig = ''
          # Background colors - all default
          set -g @tmux-dotbar-bg "default"
          set -g @tmux-dotbar-bg-prefix "default"

          # Foreground colors - vibrant and varied
          set -g @tmux-dotbar-fg "#8087a2"
          set -g @tmux-dotbar-fg-current "#eed49f"
          set -g @tmux-dotbar-fg-session "#c6a0f6"
          set -g @tmux-dotbar-fg-prefix "#8bd5ca"

          # Layout
          set -g @tmux-dotbar-position "bottom"
          set -g @tmux-dotbar-justify "absolute-centre"

          # Left status (session name with icon)
          set -g @tmux-dotbar-left "true"
          set -g @tmux-dotbar-status-left "  #S"

          # Right status (time with icon)
          set -g @tmux-dotbar-right "true"
          set -g @tmux-dotbar-status-right "  %H:%M"

          # Window status
          set -g @tmux-dotbar-window-status-format " #W "
          set -g @tmux-dotbar-window-status-separator " • "

          # Maximized icon
          set -g @tmux-dotbar-maximized-icon "󰊓"
          set -g @tmux-dotbar-show-maximized-icon-for-all-tabs false
        '';
      }

      # Session persistence
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
  };
}
