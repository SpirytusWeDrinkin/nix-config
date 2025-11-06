{
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.windowManager;

  bemenu-launcher = pkgs.writeShellScriptBin "bemenu-launcher" ''
    exec ${pkgs.bemenu}/bin/bemenu-run \
      --ab '#24273a' \
      --af '#cad3f5' \
      --binding vim \
      --cw 15 \
      --fb '#24273a' \
      --ff '#cad3f5' \
      --fn 'IosevkaTerm Nerd Font Semi-Bold 14' \
      --hb '#24273a' \
      --hf '#eed49f' \
      --hp 10 \
      --ignorecase \
      --line-height 38 \
      --nb '#24273a' \
      --nf '#cad3f5' \
      --prompt '  ' \
      --tb '#24273a' \
      --tf '#ed8796' \
      --vim-esc-exits \
      --wrap
  '';
in
{
  imports = [
    inputs.mango.hmModules.mango
  ];
  wayland.windowManager.mango = {
    enable = true;
    autostart_sh = ''
      set -e
      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots &
      ${pkgs.xdg-desktop-portal-wlr}/libexec/xdg-desktop-portal-wlr &
      ${pkgs.swaynotificationcenter}/bin/swaync &
      ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular --reconnect-tries 0 &
      ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent &
      PRIMARY_RULE=monitorrule=${cfg.primaryDisplay.port},0.55,1,tile,${toString cfg.primaryDisplay.transform},${toString cfg.primaryDisplay.scale},${toString cfg.primaryDisplay.x},${toString cfg.primaryDisplay.y},${toString cfg.primaryDisplay.width},${toString cfg.primaryDisplay.height},${toString cfg.primaryDisplay.refreshRate}
      ${pkgs.my-scripts.monitor-manager}/bin/monitor-manager --no-override
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.wpaperd}/bin/wpaperd
    '';
    settings = ''
      # More option see https://github.com/DreamMaoMao/maomaowm/wiki/

      env=PRIMARY_RULE,monitorrule=${cfg.primaryDisplay.port},0.55,1,tile,${toString cfg.primaryDisplay.transform},${toString cfg.primaryDisplay.scale},${toString cfg.primaryDisplay.x},${toString cfg.primaryDisplay.y},${toString cfg.primaryDisplay.width},${toString cfg.primaryDisplay.height},${toString cfg.primaryDisplay.refreshRate}
      # monitorrule=${cfg.secondaryDisplay.port},0.55,1,tile,${toString cfg.secondaryDisplay.transform},${toString cfg.secondaryDisplay.scale},${toString cfg.secondaryDisplay.x},${toString cfg.secondaryDisplay.y},${toString cfg.secondaryDisplay.width},${toString cfg.secondaryDisplay.height},${toString cfg.secondaryDisplay.refreshRate}
      bind=SUPER,d,spawn,${bemenu-launcher}/bin/bemenu-launcher
      bind=SUPER,Return,spawn,${pkgs.ghostty}/bin/ghostty
      bind=SUPER,x,spawn,${pkgs.swaylock}/bin/swaylock -i ${config.windowManager.lockscreen} --indicator-radius 100
      bind=SUPER,s,spawn,${pkgs.my-scripts.screenshot}
      # bind=SUPER,p,spawn,${pkgs.my-scripts.wlr-monitor-switch}
      bind=SUPER,p,spawn,${pkgs.my-scripts.monitor-manager}/bin/monitor-manager
      bind=SUPER,w,spawn,${pkgs.swww}/bin/swww img ${config.windowManager.wallpaper}

      ${builtins.readFile ./config/bind.conf}
      ${builtins.readFile ./config/config.conf}
      ${builtins.readFile ./config/env.conf}
      ${builtins.readFile ./config/rule.conf}

      source=~/.local/state/maomao/monitor.conf
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
