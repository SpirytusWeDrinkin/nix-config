{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.abelc.steam;
in
{
  options.abelc.steam = { enable = mkEnableOption "steam"; };
  config = mkIf cfg.enable {
    # Steam Configuration
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
