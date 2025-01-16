{ pkgs
, stateVersion
, lib
, rootPath
, username
, ...
}:
{
  abelc = {
    alacritty.enable = true;
    bemenu.enable = true;
    firefox.enable = true;
    gtk.enable = true;
    hyprland = {
      enable = true;
      wallpaper = "${rootPath}/assets/Wallpapers/touhousa.png";
    };
    mako.enable = true;
    nvim.enable = true;
    waybar.enable = true;
    zsh.enable = true;
  };

  abelc.git = {
    enable = true;
    editor = "nvim";
    username = "abel.chartier";
    email = "abel.chartier@epita.fr";
  };

  home = {
    inherit stateVersion;
    packages = with pkgs; [
      vivaldi
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;
}
