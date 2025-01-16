{ config, lib, ... }:
with lib;
let
  cfg = config.abelc.alacritty;
in
{
  options.abelc.alacritty = { enable = mkEnableOption "alacritty"; };
  config = mkIf cfg.enable {
    home.file.".config/alacritty" = {
      recursive = true;
      source = ./config;
    };

    programs.alacritty.enable = true;
  };
}
