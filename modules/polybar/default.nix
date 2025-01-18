{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.abelc.polybar;
in 
  {
  options.abelc.polybar = { enable = mkEnableOption "polybar"; };
  config = mkIf cfg.enable {
    services.polybar = {
      enable = true;
      script = "polybar";
      settings = {
        bar = {
          main = {
            background = "#e0374247";
            borderColor = "#e0374247";
            borderSize = "5pt";
            cursorClick = "pointer";
            cursorScroll = "ns-resize";
            enableIpc = true;
            fonts = [
              "IosevkaTerm Nerd Font:style=ExtraBold:size=13;4"
              "IosevkaTerm Nerd Font:style=ExtraBold:size=22;5"
              "IosevkaTerm Nerd Font:style=ExtraBold:size=24;6"
              "IosevkaTerm Nerd Font:style=ExtraBold:size=26;6"
              "Rounded Mgen+ 1p:style=bold:size=13;4"
            ];
            foreground = "#d3c6aa";
            height = "23pt";
            lineSize = "1pt";
            moduleMargin = 0;
            modules = {
              center = "left xworkspaces right";
              left = "left date space sep space time space sep space upeth space space downeth right space-alt";
              right = "left temperature space sep space cpu space sep space memory space sep space ethernet space sep space dunst space sep space alsa space sep space battery right";
            };
            paddingLeft = 0;
            paddingRight = 0;
            radius = 0;
            width = "100%";
            wmRestack = "i3";
          };
        };

        modules = {
          alsa = {
            formatVolume = "<ramp-volume><label-volume>";
            formatVolumeBackground = "#2f383e";
            interval = 5;
            labelMuted = "󰝟 Muted";
            labelMutedBackground = "#2f383e";
            labelMutedForeground = "#e67e80";
            labelVolume = "%percentage%%";
            masterMixer = "Master";
            masterSoundcard = "default";
            rampVolume = [ "󰕿" "󰖀" "󰕾" ];
            rampVolumeForeground = "#83c092";
            type = "internal/alsa";
          };

          battery = {
            adapter = "ADP1";
            animationsCharging = [ "" "" "" "" "" ];
            animationChargingForeground = "#7fbbb3";
            animationChargingFramerate = 750;
            barCapacityWidth = 10;
            battery = "BAT1";
            formatCharging = "<animation-charging> <label-charging>";
            formatChargingBackground = "#2f383e";
            formatDischarging = "<ramp-capacity> <label-discharging>";
            formatDischargingBackground = "#2f383e";
            formatFull = "<label-full>";
            formatFullBackground = "#2f383e";
            formatFullForeground = "#7fbbb3";
            fullAt = 99;
            labelCharging = "%percentage%%";
            labelDischarging = "%percentage%%";
            labelFull = "%{F#7fbbb3} %{F-}100%";
            pollInterval = 5;
            rampCapacity = [ "" "" "" "" "" ];
            rampCapacityForeground = "#7fbbb3";
            timeFormat = "%H:%M";
            type = "internal/battery";
          };

          cpu = {
            formatBackground = "#2f383e";
            formatPrefix = "󰍛";
            formatPrefixForeground = "#e69875";
            interval = 2;
            label = "%percentage:2%%";
            type = "internal/cpu";
          };

          date = {
            date = "%a, %d %b";
            interval = 100;
            label = "%date%";
            labelBackground = "#2f383e";
            labelForeground = "#e67e80";
            type = "internal/date";
          };

          dunst = {
            formatBackground = "#2f383e";
            formatForeground = "#dbbc7f";
            hooks = [
              "echo \"%{A1:dunstctl set-paused true && polybar-msg hook dunst 2:} %{A}\" &"
              "echo \"%{A1:dunstctl set-paused false && polybar-msg hook dunst 1:} %{A}\" &"
            ];
            initial = 1;
            type = "custom/ipc";
          };

          left = {
            content = "%{T3}%{T-}";
            contentBackground = "#e0374247";
            contentFont = 2;
            contentForeground = "#2f383e";
            type = "custom/text";
          };

          memory = {
            formatBackground = "#2f383e";
            formatPrefix = "󰑭";
            formatPrefixForeground = "#dbbc7f";
            interval = 2;
            label = "%percentage_used:2%%";
            type = "internal/memory";
          };
          "module/right" = {
            type = "custom/text";
            content = "%{T3}%{T-}";
            content-background = "#e0374247";
            content-font = 2;
            content-foreground = "#2f383e";
          };

          "module/sep" = {
            type = "custom/text";
            content = "/";
            content-background = "#2f383e";
            content-font = 4;
            content-foreground = "#e0374247";
            content-padding = 0;
          };

          "module/space" = {
            type = "custom/text";
            content = " ";
            content-background = "#2f383e";
          };

          "module/space-alt" = {
            type = "custom/text";
            content = " ";
          };

          "module/spotify" = {
            type = "custom/script";
            exec = "bash ~/.config/polybar/polybar-scripts/get_spotify_status.sh";
            format-background = "#2f383e";
            format-foreground = "#a7c080";
            format-prefix = " ";
            interval = 1;
            label = "%output:0:22:...%";
            tail = true;
          };

          "module/temperature" = {
            type = "internal/temperature";
            base-temperature = 20;
            format = "<ramp><label>";
            format-background = "#2f383e";
            format-warn = "<ramp><label-warn>";
            format-warn-background = "#2f383e";
            interval = 0.5;
            label = "%temperature-c%";
            label-warn = "%temperature-c%";
            label-warn-foreground = "#e67e80";
            ramp = [ " " " " " " " " " " ];
            ramp-foreground = "#e67e80";
            thermal-zone = 0;
            warn-temperature = 75;
          };

          "module/time" = {
            type = "internal/date";
            interval = 100;
            label = "%time%";
            label-background = "#2f383e";
            label-foreground = "#e69875";
            time = "%H:%M";
          };

          "module/weather" = {
            type = "custom/script";
            exec = "bash ~/.config/polybar/polybar-scripts/weather-plugin.sh || nope";
            format-background = "#2f383e";
            interval = 60;
            tail = false;
          };

          "module/ethernet" = {
            type = "internal/network";
            interface-type = "wired";
            interval = 1;
            format-connected = "<label-connected>";
            format-connected-background = "#2f383e";
            format-connected-foreground = "#a7c080";
            format-disconnected-background = "#2f383e";
            format-disconnected-foreground = "#e67e80";
            label-connected = "󰈀 ";
            label-disconnected = " ";
          };

          "module/xworkspaces" = {
            type = "internal/xworkspaces";
            strip-wsnumber = true;
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
          };

          "module/upeth" = {
            type = "internal/network";
            interface-type = "wired";
            interval = 1;
            format-connected = "<label-connected>";
            format-connected-prefix = " ";
            format-connected-prefix-foreground = "#a6da95";
            label-connected = "%upspeed:8%";
            format-connected-background = "#2f383e";
            format-connected-foreground = "#a6da95";
            format-disconnected-background = "#2f383e";
            format-disconnected-prefix = "";
            format-disconnected-prefix-foreground = "#a6da95";
            label-disconnected = "";
          };

          "module/downeth" = {
            type = "internal/network";
            interface-type = "wired";
            interval = 1;
            format-connected = "<label-connected>";
            format-connected-prefix = " ";
            format-connected-prefix-foreground = "#ed8796";
            label-connected = "%downspeed:8%";
            format-connected-background = "#2f383e";
            format-connected-foreground = "#ed8796";
            format-disconnected-background = "#2f383e";
            format-disconnected-prefix = "";
            format-disconnected-prefix-foreground = "#ed8796";
            label-disconnected = "";
          };
        };
      };
    };
    home.file.".config/polybar/polybar-scripts" = {
      recursive = true;
      source = ./polybar-scripts;
    };
  };
}
