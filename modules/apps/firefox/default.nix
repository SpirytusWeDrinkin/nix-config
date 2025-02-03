{ lib, config, ... }:
with lib;
let
  cfg = config.apps.firefox;
in
{
  options.apps.firefox = { enable = mkEnableOption "firefox"; };
  config = mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
