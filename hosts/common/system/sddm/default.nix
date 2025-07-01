{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = false;
    theme = "sddm-theme-corners";
  };

  services.libinput.enable = true;
  environment.systemPackages = with pkgs; [ sddm-theme ];
}
