{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.windowManager;
in
{
  options.windowManager = {
    wallpaper = mkOption {
      type = types.nullOr types.path;
      description = "Wallpaper for the wm";
      default = null;
    };

    lockscreen = mkOption {
      type = types.nullOr types.path;
      description = "Wallpaper for lockscreen";
      default = cfg.wallpaper;
    };

    lockscreen_2 = mkOption {
      type = types.nullOr types.path;
      description = "Troll wallpaper";
      default = null;
    };

    barCmd = mkOption {
      type = types.str;
      description = "Command for launching the bar";
      default = "";
    };

    terminal = mkOption {
      type = types.nullOr types.package;
      description = "terminal launched by the wm shortcut";
      default = pkgs.alacritty;
    };

    mainScreen = {
      port = mkOption {
        type = types.str;
        description = "Main screen port, see the command to get monitor";
        default = "eDP-1";
      };
      scale = mkOption {
        type = types.int;
        description = "Main screen scale";
        default = 1;
      };
    };
    secondScreen = {
      port = mkOption {
        type = types.str;
        description = "Secondary screen port, see the command to get monitor";
        default = "HDMI-A-1";
      };
      scale = mkOption {
        type = types.int;
        description = "Secondary screen scale";
        default = 1;
      };
      x = mkOption {
        type = types.int;
        description = "x-pos for secondary screen";
        default = 1920;
      };
      y = mkOption {
        type = types.int;
        description = "y-pos for secondary screen";
        default = 0;
      };
      transform = mkOption {
        type = types.int;
        description = "Transform for secondary screen";
        default = 0;
      };
    };
  };
}
