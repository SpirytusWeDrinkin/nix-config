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

  apps = {
    alacritty.enable = true;
    nvim.enable = true;
    zsh.enable = true;
  };

  graphical = {
    i3 = {
      enable = true;
      wallpaper = "${rootPath}/assets/Wallpapers/dieAlonely.png";
      barCmd = "polybar-msg cmd quit; polybar main 2>&1 | tee -a /tmp/polybar.log & disown";
    };
    polybar.enable = true;
  };

  misc = {
    bemenu.enable = true;
    gtk.enable = true;
    dunst.enable = true;
    mako.enable = true;
    git = {
      enable = true;
      editor = "nvim";
      username = "abel.chartier";
      email = "abel.chartier@epita.fr";
    };
  };

  dev.epita.java_workshop = {
    enable = true;
    jdtls = true;
  };

  home = {
    packages = with pkgs; [
      lsd
      nerd-fonts.iosevka-term
      rounded-mgenplus
      jq
    ];
  };

  services.ssh-agent.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = stateVersion;
}
