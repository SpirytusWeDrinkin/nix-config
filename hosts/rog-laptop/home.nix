{ pkgs
, stateVersion
, lib
, rootPath
, username
, inputs
, ...
}:
{
  apps = {
    alacritty.enable = true;
    firefox.enable = true;
    # nvim.enable = true;
    zsh.enable = true;
  };

  graphical = {
    hyprland = {
      enable = true;
      wallpaper = "${rootPath}/assets/Wallpapers/gravityFalls.png";
    };
    waybar.enable = true;
  };

  misc = {
    bemenu.enable = true;
    gtk.enable = true;
    mako.enable = true;
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
