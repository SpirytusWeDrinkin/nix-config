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
    cava.enable = true;
    dunst.enable = true;
    gtk.enable = true;
    i3 = {
      enable = true;
      wallpaper = "${rootPath}/assets/Wallpapers/touhousa.png";
      barCmd = "polybar-msg cmd quit; polybar main 2>&1 | tee -a /tmp/polybar.log & disown";
    };
    mako.enable = true;
    nvim.enable = true;
    polybar.enable = true;
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
      lsd
      nerd-fonts.iosevka-term
      rounded-mgenplus
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = stateVersion;
}
