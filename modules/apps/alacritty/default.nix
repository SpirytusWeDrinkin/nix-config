{ config, lib, ... }:
with lib;
let
  cfg = config.apps.alacritty;
in
{
  options.apps.alacritty = { enable = mkEnableOption "alacritty"; };
  config = mkIf cfg.enable {
    home.file.".config/alacritty" = {
      recursive = true;
      source = ./config;
    };

    programs.alacritty.enable = true;
  };
}
