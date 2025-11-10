{ config, pkgs, ... }:

{
  programs.vivaldi = {
    enable = true;

    # Command line flags/arguments
    commandLineArgs = [
      "--no-sandbox" # Required when running without root permissions
      "--enable-features=VaapiVideoDecoder" # Hardware video acceleration
      "--disable-features=UseChromeOSDirectVideoDecoder"
      "--enable-wayland-ime" # Wayland IME support
      "--gtk-version=4" # Use GTK4
    ];

    # Extensions (using Chrome Web Store IDs)
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
    ];
  };

  # Additional Vivaldi-related packages
  home.packages = with pkgs; [
    vivaldi-ffmpeg-codecs # For additional codec support
  ];

  # XDG integration (optional)
  xdg.mimeApps.defaultApplications = {
    "text/html" = "vivaldi-stable.desktop";
    "x-scheme-handler/http" = "vivaldi-stable.desktop";
    "x-scheme-handler/https" = "vivaldi-stable.desktop";
    "x-scheme-handler/about" = "vivaldi-stable.desktop";
    "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
  };
}
