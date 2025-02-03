{ lib, config, pkgs-local, ... }:
with lib;
let
  cfg = config.system.sddm;
in
{
  options.system.sddm = { enable = mkEnableOption "sddm"; };
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
