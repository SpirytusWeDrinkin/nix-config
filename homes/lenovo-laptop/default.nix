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

    ../common/apps/bat
    ../common/apps/btop
    ../common/apps/cava
    ../common/apps/direnv
    ../common/apps/fzf
    ../common/apps/imv
    ../common/apps/ghostty
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
  home.homeDirectory = "/home/${username}";

  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "Abel Chartier";
        user.email = "abel.chartier@epita.fr";
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
    lockscreen = "${rootPath}/assets/Wallpapers/cisco.png";
    terminal = pkgs.ghostty;
  };

  home = {
    inherit stateVersion;
    packages = with pkgs; [
      inputs.nixvim.packages.x86_64-linux.default
      nodejs_20
      yarn
      firefox
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;
}
