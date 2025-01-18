{ pkgs
, username
, rootPath
, stateVersion
, ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;

  abelc = {
    alacritty.enable = true;
    bemenu.enable = true;
    gtk.enable = true;
    i3 = {
      enable = true;
      wallpaper = "${rootPath}/assets/Wallpapers/touhousa.png";
    };
    mako.enable = true;
    # nvim.enable = true;
    i3status-rust.enable = true;
    zsh.enable = true;
  };

  abelc.git = {
    enable = true;
    editor = "nvim";
    username = "abel.chartier";
    email = "abel.chartier@epita.fr";
  };

  home = {
    packages = with pkgs; [
      cmatrix
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = stateVersion;
}
