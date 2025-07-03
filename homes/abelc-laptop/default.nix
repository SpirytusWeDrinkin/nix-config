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
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = username;
  home.homeDirectory = "/home/${username}";

  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;

  programs = {
    git = {
      enable = true;
      userName = "abel.chartier";
      userEmail = "abel.chartier@epita.fr";
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

  graphical = {
    i3 = {
      enable = true;
      wallpaper = "${rootPath}/assets/Wallpapers/gravityFalls.png";
      lockscreen_2 = "${rootPath}/assets/Wallpapers/romain.png";
      barCmd = "polybar-msg cmd quit; polybar main 2>&1 | tee -a /tmp/polybar.log & disown";
    };
    polybar.enable = true;
  };

  windowManager = {
    wallpaper = "${rootPath}/assets/Wallpapers/493water.jpg";
    lockscreen = "${rootPath}/assets/Wallpapers/cisco.png";
  };

  home = {
    inherit stateVersion;
    packages = with pkgs; [
      vivaldi
      inputs.nixvim.packages.x86_64-linux.default
      nodejs_20
      yarn
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;
}
