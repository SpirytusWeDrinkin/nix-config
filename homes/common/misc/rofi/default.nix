{ pkgs
, config
, lib
, ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,window";
      display-drun = "[ ]";
      display-run = "[ ]";
      display-window = "[ ]";
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          border = mkLiteral "0px";
          margin = mkLiteral "0px";
          spacing = mkLiteral "0px";
          padding = mkLiteral "0px";
        };

        "#window" = {
          width = mkLiteral "45%";
          height = mkLiteral "39.5%";
        };

        "#mainbox" = {
          children = map mkLiteral [
            "inputbar"
            "listview"
          ];
        };

        "#inputbar" = {
          children = map mkLiteral [
            "prompt"
            "entry"
          ];
        };

        "#entry" = {
          padding = mkLiteral "12px";
        };

        "#prompt" = {
          padding = mkLiteral "12px";
        };

        "#listview" = {
          lines = mkLiteral "8";
        };

        "#element" = {
          children = map mkLiteral [
            "element-text"
          ];
        };

        "#element-text" = {
          padding = mkLiteral "12px";
        };

        "#element-text selected" = { };
      };
  };

  home.file.".config/rofi/leave.sh".source = ./scripts/leave.sh;
  home.file.".config/rofi/music.sh".source = ./scripts/music.sh;
}
