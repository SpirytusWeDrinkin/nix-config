{
  pkgs,
  config,
  inputs,
  ...
}:
let
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

      bind=SUPER,d,spawn,${pkgs.bemenu}/bin/bemenu-run
      bind=SUPER,Return,spawn,${pkgs.ghostty}/bin/ghostty
      bind=SUPER,x,spawn,${pkgs.swaylock}/bin/swaylock -i ${config.windowManager.lockscreen} --indicator-radius 100
      bind=SUPER,s,spawn,${pkgs.my-scripts.screenshot}
      bind=SUPER,p,spawn,${pkgs.my-scripts.wlr-monitor-switch}

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
