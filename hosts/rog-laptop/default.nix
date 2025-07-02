{
  pkgs,
  username,
  config,
  stateVersion,
  ...
}:
let
in
/*
  stateVersion = "25.05";
  username = "abelc";
*/
{
  imports = [
    ./hardware.nix
    ./pkgslist.nix
    ./graphics.nix

    ../common/system/grub
    ../common/system/sddm

    ../common/games/steam
  ];

  networking.hostName = "rog-laptop";
  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.qemu = true;

  virtualisation.virtualbox.host.enable = true;

  security.wrappers.ubridge = {
    source = "${pkgs.ubridge}/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+x,o+x";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka-term
    rounded-mgenplus
  ];

  users.users = {
    "${username}" = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      uid = 1000;
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
    };

    "guest" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      uid = 5000;
      extraGroups = [
        config.users.groups.users.name
      ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages;
    kernelParams = [
      "v4l2loopback"
      "acpi_osi=Linux"
    ];
    loader.timeout = null;
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot";
  };
  systemd.watchdog.rebootTime = "0";

  # List services that you want to enable:
  services.openssh.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "32/48000";
            pulse.default.req = "32/48000";
            pulse.max.req = "32/48000";
            pulse.min.quantum = "32/48000";
            pulse.max.quantum = "32/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "32/48000";
        resample.quality = 1;
      };
    };
  };

  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [
        "hsp_hs"
        "hsp_ag"
        "hfp_hf"
        "hfp_ag"
      ];
    };
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  security.pam.services.hyprlock = { };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  system.stateVersion = stateVersion;
}
