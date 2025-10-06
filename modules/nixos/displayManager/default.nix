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
  options.displayManager = {
    theme = {
      package = mkOption {
        type = types.nullOr types.package;
        description = "Display manager theme";
        default = null;
      };
      name = mkOption {
        type = types.nullOr types.str;
        description = "Display manager theme name";
        default = "sddm-theme-corners";
      };
    };

    i3.enable = mkOption {
      type = types.bool;
      description = "Enable i3 as window manager manager";
      default = false;
    };

    maomaowm.enable = mkOption {
      type = types.bool;
      description = "Enable maomaowm as window manager manager";
      default = false;
    };

  };
}
