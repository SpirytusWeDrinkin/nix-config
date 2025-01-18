{ pkgs, lib, config }:
with lib;
let
  cfg = config.abelc.polybar;
in 
  {
  options.abelc.polybar = { enable = mkEnableOption "polybar"; };
  config = mkIf cfg.enable {
    services.polybar = {
      enabe = true;
      settings = {
        "bar/main" = {
          background = "#e0374247";
          border-color = "#e0374247";
          border-size = "5pt";
          cursor-click = "pointer";
          cursor-scroll = "ns-resize";
          enable-ipc = true;
          font = [
            "IosevkaTerm Nerd Font:style=ExtraBold:size=13;4"
            "IosevkaTerm Nerd Font:style=ExtraBold:size=22;5"
            "IosevkaTerm Nerd Font:style=ExtraBold:size=24;6"
            "IosevkaTerm Nerd Font:style=ExtraBold:size=26;6"
            "Rounded Mgen+ 1p:style=bold:size=13;4"
          ];
          foreground = "#d3c6aa";
          height = "23pt";
          line-size = "1pt";
          module-margin = 0;
          modules-center = "left xworkspaces right";
          modules-left = "left date space sep space time space sep space upeth space space downeth right space-alt";
          modules-right = "left temperature space sep space cpu space sep space memory space sep space ethernet space sep space dunst space sep space alsa space sep space battery right";
          padding-left = 0;
          padding-right = 0;
          radius = 0;
          width = "100%";
          wm-restack = "i3";
        };

        "module/alsa" = {
          format.volume = "<ramp-volume><label-volume>";
          format-volume-background = "#2f383e";
          interval = 5;
          label-muted = "󰝟 Muted";
          label-muted-background = "#2f383e";
          label-muted-foreground = "#e67e80";
          label-volume = "%percentage%%";
          master-mixer = "Master";
          master-soundcard = "default";
          ramp.volume = [
            "󰕿 "
            "󰖀 "
            "󰕾 "
          ];
          ramp-volume-foreground = "#83c092";
          type = "internal/alsa";
        };

        "module/battery" = {
          adapter = "ADP1";
          animation-charging = [
            " "
            " "
            " "
            " "
            " "
          ];
          animation-charging-foreground = "#7fbbb3";
          animation-charging-framerate = 750;
          bar-capacity-width = 10;
          battery = "BAT1";
          format-charging = "<animation-charging> <label-charging>";
          format-charging-background = "#2f383e";
          format-discharging = "<ramp-capacity> <label-discharging>";
          format-discharging-background = "#2f383e";
          format-full = "<label-full>";
          format-full-background = "#2f383e";
          format-full-foreground = "#7fbbb3";
          full-at = 99;
          label-charging = "%percentage%%";
          label-discharging = "%percentage%%";
          label-full = "%{F#7fbbb3} %{F-}100%";
          poll-interval = 5;
          ramp-capacity = [
            " "
            " "
            " "
            " "
            " "
          ];
          ramp-capacity-foreground = "#7fbbb3";
          time-format = "%H:%M";
          type = "internal/battery";
        };

        "module/cpu" = {
          format-background = "#2f383e";
          format-prefix = "󰍛 ";
          format-prefix-foreground = "#e69875";
          interval = 2;
          label = "%percentage:2%%";
          type = "internal/cpu";
        };

        "module/date" = {
          date = "%a, %d %b";
          interval = 100;
          label = "%date%";
          label-background = "#2f383e";
          label-foreground = "#e67e80";
          type = "internal/date";
        };

        "module/dunst" = {
          format-background = "#2f383e";
          format-foreground = "#dbbc7f";
          hook-0 = "echo \"%{A1:dunstctl set-paused true && polybar-msg hook dunst 2:} %{A}\" &";
          hook-1 = "echo \"%{A1:dunstctl set-paused false && polybar-msg hook dunst 1:} %{A}\" &";
          initial = 1;
          type = "custom/ipc";
        };

        "module/ethernet" = {
          format-connected = "<label-connected>";
          format-connected-background = "#2f383e";
          format-connected-foreground = "#a7c080";
          format-disconnected-background = "#2f383e";
          format-disconnected-foreground = "#e67e80";
          interface-type = "wired";
          interval = 1;
          label-connected = "󰈀 ";
          label-disconnected = " ";
          type = "internal/network";
        };

        "module/xworkspaces" = {
          label-active = "%name%";
          label-active-background = "#2f383e";
          label-active-foreground = "#e67e80";
          label-active-padding = 1;
          label-empty = "%name%";
          label-empty-background = "#2f383e";
          label-empty-padding = 1;
          label-occupied = "%name%";
          label-occupied-background = "#2f383e";
          label-occupied-foreground = "#eaedc8";
          label-occupied-padding = 1;
          label-urgent = "%name%";
          label-urgent-background = "#2f383e";
          label-urgent-foreground = "#dbbc7f";
          label-urgent-padding = 1;
          strip-wsnumber = true;
          type = "internal/xworkspaces";
        };
      };
    };
  };
}
