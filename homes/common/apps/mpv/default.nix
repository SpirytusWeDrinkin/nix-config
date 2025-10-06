{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yt-dlp
  ];
  programs.mpv = {
    enable = true;

    # Main mpv.conf settings
    config = {
      # Simpler UI
      osd-level = 1;
      osd-duration = 2000;
      osd-bar = "no";
      border = "no";

      # Performance
      hwdec = "auto";
      vo = "gpu";
    };

    # Vim-like keybindings in input.conf
    bindings = {
      # Navigation (vim style)
      "h" = "seek -5";
      "l" = "seek 5";
      "j" = "seek -60";
      "k" = "seek 60";
      "H" = "playlist-prev";
      "L" = "playlist-next";

      # Volume (like vim)
      "+" = "add volume 2";
      "-" = "add volume -2";

      # Speed control
      "[" = "multiply speed 0.9091";
      "]" = "multiply speed 1.1";

      # Toggle fullscreen
      "f" = "cycle fullscreen";

      # Quit
      "q" = "quit";
      "Q" = "quit-watch-later";

      # Playback
      "SPACE" = "cycle pause";
      "p" = "cycle pause";
    };

    # Scripts (optional)
    scripts = with pkgs.mpvScripts; [
      mpris
      thumbnail
    ];
  };
}
