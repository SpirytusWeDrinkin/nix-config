{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.abelc.mako;
in
{
  options.abelc.mako = { enable = mkEnableOption "mako"; };
  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      anchor = "top-right";
      defaultTimeout = 10000;
    };
  };
}
