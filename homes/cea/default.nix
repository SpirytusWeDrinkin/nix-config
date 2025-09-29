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
    ../common/apps/fzf
    ../common/apps/imv
    ../common/apps/ghostty
    ../common/apps/tmux
    ../common/apps/zsh

    ../common/launchers/bemenu

    ../common/notifications/swaync

    ../common/windowManagers/maomaowm

    ../common/widgets/gtk
    ../common/widgets/waybar
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
      userName = "Abel Chartier";
      userEmail = email;
      extraConfig = {
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
    wallpaper = "${rootPath}/assets/Wallpapers/493water.jpg";
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
      port = "DP-3";
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
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = stateVersion;
}
