{
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.windowManager;
in
{
  imports = [
    inputs.maomaowm.hmModules.maomaowm
  ];
  wayland.windowManager.maomaowm = {
    enable = true;
    autostart_sh = ''
      set -e
      ${pkgs.swww}/bin/swww-daemon &
      ${pkgs.swww}/bin/swww img ${config.windowManager.wallpaper} &
      ${pkgs.waybar}/bin/waybar &
    '';
    settings = ''
      # More option see https://github.com/DreamMaoMao/maomaowm/wiki/

      monitorrule=${cfg.mainScreen.port},0.55,1,tile,0,${toString cfg.mainScreen.scale},0,0
      monitorrule=${cfg.secondaryScreen.port},0.55,1,tile,${toString cfg.secondaryScreen.transfrom},${toString cfg.secondaryScreen.scale},${toString cfg.secondaryScreen.x},${toString cfg.secondaryScreen.y}

      bind=SUPER,d,spawn,${pkgs.bemenu}/bin/bemenu-run
      bind=SUPER,Return,spawn,${pkgs.ghostty}/bin/ghostty
      bind=SUPER,x,spawn,${pkgs.swaylock}/bin/swaylock -i ${config.windowManager.lockscreen} --indicator-radius 100
      bind=SUPER,s,spawn,${pkgs.my-scripts.screenshot}
      bind=SUPER,p,spawn,${pkgs.my-scripts.wlr-monitor-switch}
      bind=SUPER,w,spawn,${pkgs.swww}/bin/swww img ${config.windowManager.wallpaper}

      ${builtins.readFile ./config/bind.conf}
      ${builtins.readFile ./config/config.conf}
      ${builtins.readFile ./config/env.conf}
      ${builtins.readFile ./config/rule.conf}
    '';
  };
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-fancy;
  };
}
