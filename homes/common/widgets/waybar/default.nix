{
  pkgs,
  ...
}:
let
  colors = {
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
in
{
  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
      reload_style_on_change = true;
      height = 38;

      modules-left = [
        "custom/launcher"
        "dwl/tags"
        "dwl/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "tray"
        "custom/notification"
        "network"
        "pulseaudio"
        "backlight"
        "cpu"
        "temperature"
        "memory"
        "battery"
        "custom/power"
      ];

      "dwl/tags" = {
        num-tags = 9;
        hide-vacant = true;
        tag-labels = [
          "一"
          "二"
          "三"
          "四"
          "五"
          "六"
          "七"
          "八"
          "九"
        ];
      };

      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 22;
        all-outputs = false;
        tooltip-format = "{title}";
        markup = true;
        on-click = "activate";
        on-click-right = "close";
        ignore-list = [
          "Rofi"
          "wofi"
        ];
      };

      "dwl/window" = {
        format = "{}";
        format-alt = "maomaowm";
        max-length = 50;
        tooltip = true;
        tooltip-format = "{}";
        rewrite = {
          "^$" = "maomaowm";
          # Clean up common window title patterns
          "(.*) — Mozilla Firefox" = " $1";
          "(.*) - Mozilla Firefox" = " $1";
          "(.*) — Qutebrowser" = "󰖟 $1";
          "(.*) - Qutebrowser" = "󰖟 $1";
          "(.*) — Visual Studio Code" = " $1";
          "(.*) - Visual Studio Code" = " $1";
          "(.*) — Neovim" = " $1";
          "(.*) - Neovim" = " $1";
          "nvim (.*)" = " $1";
          "vim (.*)" = " $1";
          "nvim" = " ";
          "(.*) — Terminal" = "󱙝 $1";
          "(.*) - Terminal" = "󱙝 $1";
          "^Terminal$" = "󱙝 Terminal";
          "^Discord$" = " Discord";
          "WebCord - (.*)" = " $1";
          "^Spotify$" = " Spotify";
          # Remove common suffixes that don't add value
          " - zsh$" = "";
          " - bash$" = "";
          " \\[.*\\]$" = "";
        };
      };

      # Notification module
      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "󰂚 ";
          none = " ";
          dnd-notification = "󰂛 ";
          dnd-none = " ";
          inhibited-notification = "󰂚 ";
          inhibited-none = " ";
          dnd-inhibited-notification = "󰂚 ";
          dnd-inhibited-none = " ";
        };
        return-type = "json";
        exec-if = "which ${pkgs.swaynotificationcenter}/bin/swaync-client";
        exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
        on-click = "sleep 0.1s && ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
        on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
        escape = true;
      };

      tray = {
        interval = 1;
        icon-size = 18;
        spacing = 10;
      };

      pulseaudio = {
        tooltip = false;
        scroll-step = 2;
        format = "{icon} {volume:3}%";
        format-muted = "  {volume:3}%";
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        format-icons = {
          default = [
            " "
            " "
            " "
          ];
        };
      };

      network = {
        tooltip = true;
        interval = 2;
        format-wifi = "{icon} {essid}";
        format-icons = [
          "󰤯 "
          "󰤟 "
          "󰤢 "
          "󰤥 "
          "󰤨 "
        ];
        format-ethernet = "󰈀 {ifname}";
        format-linked = " No IP ({ifname})";
        format-disconnected = " Disconnected";
        tooltip-format = "{ifname} {ipaddr}/{cidr} via {gwaddr}";
      };

      backlight = {
        device = "amdgpu_bl2";
        interval = 2;
        format = "{icon} {percent:3}%";
        format-icons = [
          "󱩎 "
          "󱩏 "
          "󱩐 "
          "󱩑 "
          "󱩒 "
          "󱩓 "
          "󱩔 "
          "󱩕 "
          "󱩖 "
          "󰛨 "
        ];
        on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set +2%";
        on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
        smooth-scrolling-threshold = 1;
      };

      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 20;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-alt = "{time} {icon}";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];
      };

      clock = {
        format = "{:%H:%M    %d/%m/%Y}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months = "<span color='#${colors.pink}'><b>{}</b></span>";
            days = "<span color='#${colors.lavender}'><b>{}</b></span>";
            weeks = "<span color='#${colors.mauve}'><b>W{}</b></span>";
            weekdays = "<span color='#${colors.mauve}'><b>{}</b></span>";
            today = "<span color='#${colors.red}'><b>{}</b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-scroll-up = [
            "tz_up"
            "shift_up"
          ];
          on-scroll-down = [
            "tz_down"
            "shift_down"
          ];
        };
      };

      cpu = {
        interval = 2;
        format = "󰍛 {usage:3}%";
        max-length = 10;
      };

      temperature = {
        format = "{temperatureC:2}°C ";
      };

      memory = {
        interval = 30;
        format = " {percentage:3}%";
        max-length = 10;
      };

      "custom/launcher" = {
        format = " ";
        on-click = "${pkgs.bemenu}/bin/bemenu-run";
      };

      "custom/power" = {
        format = "⏻ ";
        tooltip = false;
        on-click = "${pkgs.wlogout}/bin/wlogout -b 3 --protocol layer-shell";
      };
    };
  };

  # stylix.targets.waybar.enable = false;
  programs.waybar.style = builtins.readFile ./config/style.css;

  # Configure waybar as a systemd user service
  /*
    systemd.user.services.waybar = {
      Unit = {
        Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
        Documentation = "https://github.com/Alexays/Waybar/wiki";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  */

}
