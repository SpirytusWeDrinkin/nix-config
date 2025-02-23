{
  pkgs,
  stateVersion,
  rootPath,
  inputs,
  outputs,
  ...
}:
let
  homeConfigPath = rootPath + "/homes";
in
{
  imports = [
    "${homeConfigPath}/common/apps/alacritty"
    "${homeConfigPath}/common/apps/zsh"

    "${homeConfigPath}/common/misc/bemenu"
    "${homeConfigPath}/common/misc/cava"
    "${homeConfigPath}/common/misc/dunst"
    "${homeConfigPath}/common/misc/fzf"
    "${homeConfigPath}/common/misc/gtk"
    "${homeConfigPath}/common/misc/tmux"

    "${homeConfigPath}/common/graphical/hyprland"
    "${homeConfigPath}/common/graphical/waybar"
  ] ++ (builtins.attrValues outputs.homeManagerModules);

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
    inherit stateVersion;
    packages = with pkgs; [
      vivaldi
      inputs.nvim.packages.x86_64-linux.default
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;
}
