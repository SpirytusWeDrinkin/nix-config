{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.abelc.polybar;
  my_colors = {
    rosewater = "f4dbd6";
    flamingo = "f0c6c6";
    pink = "f5bde6";
    mauve = "c6a0f6";
    red = "ed8796";
    maroon = "ee99a0";
    peach = "f5a97f";
    yellow = "eed49f";
    green = "a6da95";
    teal = "8bd5ca";
    sky = "91d7e3";
    sapphire = "7dc4e4";
    blue = "8aadf4";
    lavender = "b7bdf8";
    text = "cad3f5";
    subtext1 = "b8c0e0";
    subtext0 = "a5adcb";
    overlay2 = "939ab7";
    overlay1 = "8087a2";
    overlay0 = "6e738d";
    surface2 = "5b6078";
    surface1 = "494d64";
    surface0 = "363a4f";
    base = "24273a";
    mantle = "1e2030";
    crust = "181926";
  };

  gradiant = with my_colors; [

  ];
in 
  {
  options.abelc.polybar = { enable = mkEnableOption "polybar"; };
  config = mkIf cfg.enable {
    services.polybar = {
      enable = true;
      script = ''
        pkill polybar
        polybar main 2>&1 | tee -a /tmp/polybar.log & disown
      '';
      settings = {
        "bar/main" = {
          background = "#e0${my_colors.crust}";
          border-color = "#e0${my_colors.crust}";
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
          foreground = "#${my_colors.text}";
          height = "23pt";
          lineSize = "1pt";
          module-margin = 0;
          modules = {
            center = "left xworkspaces right";
            left = "left date space sep space time space sep space upeth space space downeth right space-alt space-alt space-alt left music right";
            right = "left temperature space sep space cpu space sep space memory space sep space ethernet space sep space dunst space sep space alsa space sep space battery right";
          };
          padding-left = 0;
          padding-right = 0;
          radius = 0;
          width = "100%";
          wm-restack = "i3";
        };

        "module/alsa" = {
          format-volume = "<ramp-volume><label-volume>";
          format-volume-background = "#${my_colors.base}";
          interval = 5;
          label-muted = "󰝟 Muted";
          label-muted-background = "#${my_colors.base}";
          label-muted-foreground = "#${my_colors.text}";
          label-volume = "%percentage%%";
          master-mixer = "Master";
          master-soundcard = "default";
          ramp-volume = [ "󰕿 " "󰖀 " "󰕾 " ];
          ramp-volume-foreground = "#${my_colors.red}";
          type = "internal/alsa";
        };

        "module/battery" = {
          adapter = "ADP1";
          animations-charging = [ " " " " " " " " " " ];
          animation-charging-foreground = "#${my_colors.green}";
          animation-charging-framerate = 750;
          bar-capacity-width = 10;
          battery = "BAT1";
          format-charging = "<animation-charging> <label-charging>";
          format-charging-background = "#${my_colors.base}";
          format-discharging = "<ramp-capacity> <label-discharging>";
          format-dischargingBackground = "#${my_colors.base}";
          format-full = "<label-full>";
          format-full-background = "#${my_colors.base}";
          format-full-foreground = "#${my_colors.text}";
          full-at = 99;
          label-charging = "%percentage%%";
          label-discharging = "%percentage%%";
          label-full = "%{F#7fbbb3} %{F-}100%";
          poll-interval = 5;
          ramp-capacity = [ "" "" "" "" "" ];
          ramp-capacityForeground = "#${my_colors.peach}";
          time-format = "%H:%M";
          type = "internal/battery";
        };

        "module/cpu" = {
          format-background = "#${my_colors.base}";
          format-prefix = "󰍛 ";
          format-prefix-foreground = "#${my_colors.pink}";
          interval = 2;
          label = "%percentage:2%%";
          type = "internal/cpu";
        };

        "module/date" = {
          date = "%a, %d %b";
          interval = 100;
          label = "%date%";
          label-background = "#${my_colors.base}";
          label-foreground = "#${my_colors.lavender}";
          type = "internal/date";
        };

        "module/dunst" = {
          format-background = "#${my_colors.base}";
          format-foreground = "#${my_colors.yellow}";
          hooks = [
            "echo \"%{A1:dunstctl set-paused true && polybar-msg hook dunst 2:} %{A}\" &"
            "echo \"%{A1:dunstctl set-paused false && polybar-msg hook dunst 1:} %{A}\" &"
          ];
          initial = 0;
          type = "custom/ipc";
        };

        "module/left" = {
          format = "%{T3}%{T-}";
          format-background = "#e0${my_colors.crust}";
          format-font = 2;
          format-foreground = "#${my_colors.base}";
          type = "custom/text";
        };

        "module/memory" = {
          format-background = "#${my_colors.base}";
          format-prefix = "󰑭 ";
          format-prefix-foreground = "#${my_colors.maroon}";
          interval = 2;
          label = "%percentage_used:2%%";
          type = "internal/memory";
        };
        "module/right" = {
          type = "custom/text";
          format = "%{T3}%{T-}";
          format-background = "#e0${my_colors.crust}";
          format-font = 2;
          format-foreground = "#${my_colors.base}";
        };

        "module/sep" = {
          type = "custom/text";
          format = "/";
          format-background = "#${my_colors.base}";
          format-font = 4;
          format-foreground = "#e0${my_colors.crust}";
          format-padding = 0;
        };

        "module/space" = {
          type = "custom/text";
          format = " ";
          format-background = "#${my_colors.base}";
        };

        "module/space-alt" = {
          type = "custom/text";
          format = " ";
        };

        "module/music" = {
          type = "custom/script";
          exec = "~/.config/polybar/polybar-scripts/get_playerctl_status.sh";
          format-background = "#${my_colors.base}";
          format-foreground = "#${my_colors.lavender}";
          format-prefix = "  ";
          interval = 1;
          label = "%output:0:22:...%";
          tail = true;
        };

        "module/temperature" = {
          type = "internal/temperature";
          base-temperature = 20;
          format = "<ramp><label>";
          format-background = "#${my_colors.base}";
          format-warn = "<ramp><label-warn>";
          format-warn-background = "#${my_colors.base}";
          interval = 0.5;
          label = "%temperature-c%";
          label-warn = "%temperature-c%";
          label-warn-foreground = "#${my_colors.red}";
          ramp = [ " " " " " " " " " " ];
          ramp-foreground = "#${my_colors.red}";
          thermal-zone = 0;
          warn-temperature = 75;
        };

        "module/time" = {
          type = "internal/date";
          interval = 100;
          label = "%time%";
          label-background = "#${my_colors.base}";
          label-foreground = "#${my_colors.rosewater}";
          time = "%H:%M";
        };

        "module/weather" = {
          type = "custom/script";
          exec = "bash ~/.config/polybar/polybar-scripts/weather-plugin.sh || nope";
          format-background = "#${my_colors.base}";
          interval = 60;
          tail = false;
        };

        "module/ethernet" = {
          type = "internal/network";
          interface-type = "wired";
          interval = 1;
          format-connected = "<label-connected>";
          format-connected-background = "#${my_colors.base}";
          format-connected-foreground = "#${my_colors.teal}";
          format-disconnected-background = "#${my_colors.base}";
          format-disconnected-foreground = "#${my_colors.red}";
          label-connected = "󰈀 ";
          label-disconnected = " ";
        };

        "module/xworkspaces" = {
          type = "internal/xworkspaces";
          strip-wsnumber = true;
          label-active = "%name%";
          label-active-background = "#${my_colors.base}";
          label-active-foreground = "#${my_colors.mauve}";
          label-active-padding = 1;
          label-empty = "%name%";
          label-empty-background = "#${my_colors.base}";
          label-empty-padding = 1;
          label-occupied = "%name%";
          label-occupied-background = "#${my_colors.base}";
          label-occupied-foreground = "#${my_colors.surface1}";
          label-occupied-padding = 1;
          label-urgent = "%name%";
          label-urgent-background = "#${my_colors.base}";
          label-urgent-foreground = "#${my_colors.yellow}";
          label-urgent-padding = 1;
        };

        "module/upeth" = {
          type = "internal/network";
          interface-type = "wired";
          interval = 1;
          format-connected = "<label-connected>";
          format-connected-prefix = " ";
          format-connected-prefix-foreground = "#${my_colors.green}";
          label-connected = "%upspeed:8%";
          format-connected-background = "#${my_colors.base}";
          format-connected-foreground = "#${my_colors.teal}";
          format-disconnected-background = "#${my_colors.base}";
          format-disconnected-prefix = "";
          format-disconnected-prefix-foreground = "#${my_colors.red}";
          label-disconnected = "";
        };

        "module/downeth" = {
          type = "internal/network";
          interface-type = "wired";
          interval = 1;
          format-connected = "<label-connected>";
          format-connected-prefix = " ";
          format-connected-prefix-foreground = "#${my_colors.red}";
          label-connected = "%downspeed:8%";
          format-connected-background = "#${my_colors.base}";
          format-connected-foreground = "#${my_colors.red}";
          format-disconnected-background = "#${my_colors.base}";
          format-disconnected-prefix = "";
          format-disconnected-prefix-foreground = "#${my_colors.red}";
          label-disconnected = "";
        };
      };
    };
    home.file.".config/polybar/polybar-scripts" = {
      recursive = true;
      source = ./polybar-scripts;
    };
    home.packages = [ pkgs.playerctl ];
  };
}
