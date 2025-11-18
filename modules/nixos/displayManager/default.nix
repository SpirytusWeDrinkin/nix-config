{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.displayManager;
in
{
  options.displayManager = {
    theme = mkOption {
        type = types.nullOr types.package;
        description = "Display manager theme";
        default = null;
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
