{
  lib,
  config,
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
      type = type.nullOr types.package;
      description = "terminal launched by the wm shortcut";
      default = "";
    };
  };
}
