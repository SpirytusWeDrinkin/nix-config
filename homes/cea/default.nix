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

    ../common/apps/cava
    ../common/apps/fzf
    ../common/apps/ghostty
    ../common/apps/tmux
    ../common/apps/zsh

    ../common/launchers/bemenu

    ../common/notifications/dunst

    ../common/windowManagers/maomaowm

    ../common/widgets/gtk
    ../common/widgets/waybar
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = username;
  home.homeDirectory = "/home/catB/${username}";

  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;

  programs = {
    git = {
      enable = true;
      userName = username;
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
