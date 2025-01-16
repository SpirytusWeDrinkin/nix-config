{ lib, config, pkgs-local, ... }:
with lib;
let
  cfg = config.abelc.sddm;
in
{
  options.abelc.sddm = { enable = mkEnableOption "sddm"; };
  config = mkIf cfg.enable {
    services.xserver = {
      enable = false;
    };

    services.displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      theme = "sddm-theme-corners";
    };

    services.libinput.enable = true;
    environment.systemPackages = with pkgs-local; [ sddm-theme ];
  };
}
