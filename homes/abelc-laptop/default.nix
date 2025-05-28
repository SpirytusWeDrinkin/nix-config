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

    ../common/apps/ghostty
    ../common/apps/zsh

    ../common/misc/bemenu
    ../common/misc/cava
    ../common/misc/dunst
    ../common/misc/fzf
    ../common/misc/gtk
    ../common/misc/tmux

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
      terminal = "ghostty";
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
