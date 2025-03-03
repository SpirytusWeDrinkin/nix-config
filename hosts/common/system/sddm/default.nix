{pkgs, ...}: {
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
  environment.systemPackages = with pkgs; [sddm-theme];
}
