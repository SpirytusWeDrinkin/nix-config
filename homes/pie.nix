{
  pkgs,
  username,
  rootPath,
  stateVersion,
  inputs,
  ...
}:
{
  imports = [
    ./common/misc/tmux
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  manual.manpages.enable = false;
  fonts.fontconfig.enable = true;

  apps = {
    alacritty.enable = true;
    # nvim.enable = true;
    zsh.enable = true;
  };

  graphical = {
    i3 = {
      enable = true;
      wallpaper = "${rootPath}/assets/Wallpapers/gravityFalls.png";
      lockscreen_2 = "${rootPath}/assets/Wallpapers/romain.png";
      barCmd = "polybar-msg cmd quit; polybar main 2>&1 | tee -a /tmp/polybar.log & disown";
    };
    polybar.enable = true;
  };

  misc = {
    bemenu.enable = true;
    cava.enable = true;
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

  dev.java_workshop = {
    enable = true;
    jdtls = true;
  };

  home = {
    packages = with pkgs; [
      inputs.nvim.packages.x86_64-linux.default
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
