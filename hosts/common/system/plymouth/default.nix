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
    "acpi.debug_level=0"
    "acpi.debug_layer=0"
    "loglevel=3"
    "systemd.show_status=false"
    "vt.global_cursor_default=0"
    "plymouth.enable=0"
  ];

  console = {
    earlySetup = true;
    font = "Lat2-Terminus16";
  };
}
