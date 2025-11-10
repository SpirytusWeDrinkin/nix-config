{ pkgs, ... }:
{
  home.packages = [ pkgs.lollypop ];

  dconf.settings = {
    "org/gnome/Lollypop" = {
      music-uris = [ "file:///volatile/catB/ac284667/Music" ];
      shown-album-lists = [ "-10" ]; # -10 is Album Artist view
      startup-one = -10; # Opens to Album Artist on startup
    };
  };
}
