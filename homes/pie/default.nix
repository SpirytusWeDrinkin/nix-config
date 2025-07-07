{
  pkgs,
  username,
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

    ../common/apps/cava
    ../common/apps/fzf
    ../common/apps/alacritty
    ../common/apps/tmux
    ../common/apps/zsh

    ../common/launchers/bemenu

    ../common/notifications/dunst

    ../common/windowManagers/i3

    ../common/widgets/gtk
    ../common/widgets/polybar
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

  windowManager = {
    wallpaper = "${rootPath}/assets/Wallpapers/gravityFalls.png";
    terminal = pkgs.alacritty;
  };

  home = {
    packages = with pkgs; [
      inputs.nixvim.packages.x86_64-linux.default
      lsd
      nerd-fonts.iosevka-term
      rounded-mgenplus
      jq
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = stateVersion;
}
