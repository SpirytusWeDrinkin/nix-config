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
    '';
    settings = ''
      # More option see https://github.com/DreamMaoMao/maomaowm/wiki/

      monitorrule=${cfg.primaryDisplay.port},0.55,1,tile,${toString cfg.primaryDisplay.transform},${toString cfg.primaryDisplay.scale},${toString cfg.primaryDisplay.x},${toString cfg.primaryDisplay.y}
      monitorrule=${cfg.secondaryDisplay.port},0.55,1,tile,${toString cfg.secondaryDisplay.transform},${toString cfg.secondaryDisplay.scale},${toString cfg.secondaryDisplay.x},${toString cfg.secondaryDisplay.y}

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
  services.wpaperd = {
    enable = true;
    settings = {
      any = {
        path = cfg.wallpaper;
      };
    };
  };
}
