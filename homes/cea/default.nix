{
  pkgs,
  username,
  email,
  rootPath,
  stateVersion,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    ./nixpkgs.nix

    ../common/scripts/default.nix

    ../common/apps/bat
    ../common/apps/btop
    ../common/apps/cava
    ../common/apps/direnv
    ../common/apps/fzf
    ../common/apps/ghostty
    ../common/apps/imv
    ../common/apps/lollypop
    ../common/apps/mpv
    ../common/apps/qutebrowser
    ../common/apps/tmux
    ../common/apps/zsh

    ../common/launchers/bemenu

    ../common/notifications/swaync

    ../common/windowManagers/maomaowm

    ../common/widgets/gtk
    ../common/widgets/qt
    ../common/widgets/waybar
    ../common/widgets/wlogout
  ]
  ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = username;
  home.homeDirectory = "/home/catB/${username}";

  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;

  home.language = {
    base = "en_US.UTF-8";
  };

  warnings = [ "Etre aussi beau est un crime." ];

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "Abel Chartier";
        user.email = email;
        init.defaultBranch = "master";
        pull.rebase = true;
        core.editor = "nvim";
        push.autoSetupRemote = true;

        color = {
          ui = "auto";
          branch = "auto";
          diff = "auto";
          interactive = "auto";
          status = "auto";
        };

        commit.verbose = true;
        branch.autosetuprebase = "always";
        push.default = "simple";
        rebase = {
          autoSquash = true;
          autoStash = true;
        };
      };
    };
  };

  windowManager = {
    wallpaper = "${rootPath}/assets/Wallpapers/cisco.png";
    terminal = pkgs.ghostty;
    primaryDisplay = {
      port = "eDP-1";
      scale = 1;
      x = 0;
      y = 0;
      transform = 0;
      width = 1920;
      height = 1080;
      refreshRate = 60.049000;
    };
    secondaryDisplay = {
      port = "DP-2";
      scale = 1;
      x = 1920;
      y = 0;
      width = 1920;
      height = 1200;
      transform = 0;
      refreshRate = 59.950001;
    };
  };

  home = {
    packages = with pkgs; [
      inputs.nixvim.packages.x86_64-linux.default
      lsd
      nerd-fonts.iosevka-term
      rounded-mgenplus
      firefox
      jq
      xdg-desktop-portal-wlr
    ];
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = stateVersion;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };
}
