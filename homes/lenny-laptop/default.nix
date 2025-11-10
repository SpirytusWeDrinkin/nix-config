{
  pkgs,
  rootPath,
  inputs,
  outputs,
  username,
  ...
}:
let
  stateVersion = "25.05";
in
{
  imports = [
    ./nixpkgs.nix

    ../common/scripts/default.nix

    ../common/apps/cava
    ../common/apps/fzf
    ../common/apps/ghostty
    ../common/apps/tmux
    ../common/apps/zsh

    ../common/launchers/bemenu

    ../common/notifications/swaync

    ../common/windowManagers/maomaowm

    ../common/widgets/gtk
    ../common/widgets/waybar
    ../common/widgets/wlogout
  ]
  ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = username;
  home.homeDirectory = "/home/${username}";

  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;

  programs = {
    git = {
      enable = true;
      userName = "lenny.chiadmi-delage";
      userEmail = "lenny.chiadmi-delage@epita.fr";
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
    wallpaper = "${rootPath}/assets/Wallpapers/quotidien.png";
    lockscreen = "${rootPath}/assets/Wallpapers/guitarGirlOnAtower.png";
    primaryDisplay = {
      port = "eDP-1";
      scale = 1.5;
    };
    secondaryDisplay = {
      port = "HDMI-A-1";
      scale = 1;
      x = 1920;
      y = 0;
      transform = 0;
    };

  };

  home = {
    inherit stateVersion;
    packages = with pkgs; [
      inputs.nixvim.packages.x86_64-linux.default
      nodejs_20
      yarn
      zulip
      obsidian
      lunar-client
      badlion-client
      jetbrains.pycharm-professional
      docker-compose
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;
}
