{ pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };

  programs.rmpc = {
    enable = true;

    config = ''
      (
        address: "127.0.0.1:6600",
        
        theme: (
          primary_color: Mauve,
          secondary_color: Teal,
          highlight_color: Blue,
          border_color: Mauve,
          
          current_item_style: (
            fg: Some(Teal),
            modifiers: ["BOLD"],
          ),
          
          highlighted_item_style: (
            fg: Some(Mauve),
            modifiers: ["BOLD", "REVERSED"],
          ),
        ),

        keybinds: (
          global: {
            "q": Quit,
            "j": Down,
            "k": Up,
            "h": Left,
            "l": Right,
            "g": Top,
            "G": Bottom,
            "Ctrl+d": PageDown,
            "Ctrl+u": PageUp,
            "Space": TogglePause,
            ">": Next,
            "<": Previous,
            "Enter": Play,
            "a": Add,
            "d": Delete,
          },
        ),

        browser_song_sort: [AlbumArtist, Track, Artist, Title],
      )
    '';
  };
}
