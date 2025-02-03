{ config, lib, ... }:
with lib;
let
  cfg = config.system.nh;
in
{
  options.system.nh = {
    enable = mkEnableOption "nh";
    flakePath = mkOption {
      type = types.nullOr types.path;
      description = "Path of the flake for nix helper";
      default = null;
    };
  };
  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = cfg.flakePath;
    };
  };
}
