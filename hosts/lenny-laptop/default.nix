{
  pkgs,
  username,
  config,
  stateVersion,
  outputs,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./pkgslist.nix
    ./graphics.nix
    ../common/system/grub
    ../common/system/sddm
    ../common/system/pipewire
    ../common/system/plymouth
    ../common/games/steam
  ]
  ++ (builtins.attrValues outputs.nixosModules);

  networking.hostName = "lenny-laptop";
  networking.networkmanager.enable = true;

  virtualisation = {
    docker.enable = true;
    # libvirtd.enable = true;
    # virtualbox.host.enable = true;
  };

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

  displayManager = {
    theme = pkgs.sddm-theme;
    maomaowm.enable = true;
  };

  users.users = {
    "${username}" = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "dialout"
        "libvirtd"
      ];
      uid = 1000;
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
    };
    "guest" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      uid = 5000;
      extraGroups = [ config.users.groups.users.name ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages;
    kernelParams = [
      "acpi_osi=Linux"
    ];
    loader = {
      timeout = null;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
    # Steam games compatibility
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
  };

  services.openssh.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  systemd.watchdog.rebootTime = "0";

  system.stateVersion = stateVersion;
}
