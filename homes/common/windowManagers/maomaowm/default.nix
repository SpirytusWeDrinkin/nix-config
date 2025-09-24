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
    inputs.mango.hmModules.mango
  ];
  wayland.windowManager.mango = {
    enable = true;
    autostart_sh = ''
      set -e
      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
      ${pkgs.swaynotificationcenter}/bin/swaync &
      ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular --reconnect-tries 0 &
    '';
    settings = ''
      # More option see https://github.com/DreamMaoMao/maomaowm/wiki/

      monitorrule=${cfg.primaryDisplay.port},0.55,1,tile,${toString cfg.primaryDisplay.transform},${toString cfg.primaryDisplay.scale},${toString cfg.primaryDisplay.x},${toString cfg.primaryDisplay.y},${toString cfg.primaryDisplay.width},${toString cfg.primaryDisplay.height},${toString cfg.primaryDisplay.refreshRate}
      monitorrule=${cfg.secondaryDisplay.port},0.55,1,tile,${toString cfg.secondaryDisplay.transform},${toString cfg.secondaryDisplay.scale},${toString cfg.secondaryDisplay.x},${toString cfg.secondaryDisplay.y},${toString cfg.secondaryDisplay.width},${toString cfg.secondaryDisplay.height},${toString cfg.secondaryDisplay.refreshRate}

      bind=SUPER,d,spawn,${pkgs.bemenu}/bin/bemenu-run --ab '#24273a' --af '#cad3f5' --binding vim --cw 15 --fb '#24273a' --ff '#cad3f5' --fn 'IosevkaTerm Nerd Font 14' --hb '#24273a' --hf '#eed49f' --hp 10 --ignorecase --line-height 38 --nb '#24273a' --nf '#cad3f5' --prompt '  ' --tb '#24273a' --tf '#ed8796' --vim-esc-exits --wrap
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
