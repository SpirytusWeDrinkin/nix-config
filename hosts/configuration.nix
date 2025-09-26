{
  pkgs,
  outputs,
  ...
}:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
    overlays = builtins.attrValues outputs.overlays;
  };

  time.timeZone = "Europe/Paris";

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    zsh

    python311
    poetry
    docker-compose

    wget
    curl
    killall
    btop
    pciutils

    # Documentation
    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;

  programs.zsh.enable = true;

  programs.nix-ld = {
    enable = true;
  };

  environment.shells = with pkgs; [ zsh ];

  environment.variables = {
    TERMINAL = "alacritty";
    EDITOR = "vim";
    VISUAL = "vim";
  };
}
