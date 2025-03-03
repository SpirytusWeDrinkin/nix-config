{
  inputs,
  pkgs,
  ...
}:
{
  # List System Programs
  environment.systemPackages = with pkgs; [
    #Get things online
    wget
    curl
    git

    #Build tools
    cmake
    pkg-config
    meson
    appimage-run
    gnumake
    gcc
    gdb

    #Useful bin
    wl-clipboard
    grim
    slurp
    libnotify
    playerctl
    unrar
    pulseaudio
    # globalprotect-openconnect

    # Nix package bullshit
    nix-prefetch-git
    fd

    # Terminal utils
    btop
    lsd
    neofetch
    tree
    ripgrep
    vim

    # User apps
    pavucontrol
    slack
    webcord
    wayshot
    komikku
    gimp
    blueberry
    firefox

    # Infra
    kubectl
    terraform

    # Haskell
    ghc

    # ?
    noto-fonts-color-emoji
    adwaita-icon-theme
    where-is-my-sddm-theme
  ];

  programs = {
    steam.gamescopeSession.enable = true;
    dconf.enable = true;
    hyprland = {
      withUWSM = true;
      enable = true;
      # package = inputs.hyprland.packages.x86_64-linux.hyprland;
      xwayland.enable = true;
    };
  };
}
