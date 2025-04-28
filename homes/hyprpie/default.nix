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

    ../common/misc/bemenu
    ../common/misc/cava
    ../common/misc/dunst
    ../common/misc/fzf
    ../common/misc/gtk
    ../common/misc/tmux

    ../common/apps/alacritty
    ../common/apps/zsh

    ../common/graphical/hyprland
    ../common/graphical/waybar
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = username;
  home.homeDirectory = "/home/${username}";

  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;

  graphical = {
    hyprland = {
      enable = true;
      wallpaper = "${rootPath}/assets/Wallpapers/gravityFalls.png";
    };
    waybar.enable = true;
  };

  misc = {
    git = {
      enable = true;
      editor = "nvim";
      username = "abel.chartier";
      email = "abel.chartier@epita.fr";
    };
  };

  home = {
    packages = with pkgs; [
      inputs.nixvim.packages.x86_64-linux.default
      lsd
      nerd-fonts.iosevka-term
      rounded-mgenplus
      jq
      hyprland
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = stateVersion;
}
