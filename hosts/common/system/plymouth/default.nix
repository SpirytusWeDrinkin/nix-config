{ pkgs, ... }:
{
  boot.plymouth = {
    enable = true;
    themePackages = [ pkgs.catppuccin-plymouth ];
    theme = "catppuccin-macchiato";
  };

  boot.initrd.systemd.enable = true;

  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=false"
    "rd.log_level=3"
    "udev.log_priority=3"
  ];

  console = {
    earlySetup = true;
    font = "Lat2-Terminus16";
  };
}
