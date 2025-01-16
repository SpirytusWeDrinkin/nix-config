{ lib, config, ... }:
with lib;
let
  cfg = config.abelc.firefox;
in
{
  options.abelc.firefox = { enable = mkEnableOption "firefox"; };
  config = mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
