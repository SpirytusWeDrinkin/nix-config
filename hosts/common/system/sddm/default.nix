{
  config,
  lib,
  ...
}:
let
  cfg = config.windowManager;
in
{
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = cfg.maomaowm.enable;
    theme = cfg.theme.name;
  };

  services.xserver = lib.mkIf cfg.i3.enable {
    enable = true;
    windowManager.i3.enable = true;
  };

  services.libinput.enable = true;
  environment.systemPackages = [ cfg.theme.package ];
}
