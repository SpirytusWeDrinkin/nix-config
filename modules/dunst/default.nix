{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.abelc.dunst;
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
in {
  options.abelc.dunst = { enable = mkEnableOption "dunst"; };
  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "candy-icons";
        package = pkgs.candy-icons;
      };
      settings = {
        global = {
          monitor = 0;
          frame_color = "#89B4FA";
          follow = "mouse";
          width = 300;
          origin = "top-right";
          offset = "30x30";
          progress_bar = true;
          progress_bar_height = 14;
          progress_bar_frame_width = 1;
          progress_bar_min_width = 150;
          progress_bar_max_width = 300;
          indicate_hidden = true;
          shrink = false;
          separator_height = 6;
          separator_color = "#272f57";
          padding = 16;
          horizontal_padding = 16;
          frame_width = 2;
          sort = false;
          idle_threshold = 0;
          font = "IosevkaTerm Nerd Font 14";
          line_height = 0;
          markup = "full";
          format = "<b>%a</b>\n%s\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = 120;
          word_wrap = true;
          ignore_newline = false;
          stack_duplicates = false;
          show_indicators = true;
          icon_position = "left";
          min_icon_size = 50;
          max_icon_size = 60;
          sticky_history = true;
          history_length = 100;
          dmenu = "/usr/bin/bemenu-run -p dunst:";
          browser = "/usr/bin/firefox -new-tab";
          always_run_script = false;
          title = "Dunst";
          class = "Dunst";
          corner_radius = 7;
          ignore_dbusclose = false;
          force_xinerama = false;
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
        };

        experimental = {
          per_monitor_dpi = false;
        };

        urgency_low = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          highlight = "#70a5eb";
          frame_color = "#242931";
          timeout = 8;
        };

        urgency_normal = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          highlight = "#70a5eb";
          timeout = 8;
        };

        urgency_critical = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          frame_color = "#FAB387";
          highlight = "#e05f65";
          timeout = 0;
          icon = "battery-ac-adapter";
        };

        backlight = {
          appname = "Backlight";
          highlight = "#f1cf8a";
          set_stack_tag = "backlight";
        };

        music = {
          appname = "Music";
        };

        volume = {
          summary = "Volume*";
          highlight = "#70a5eb";
          set_stack_tag = "volume";
        };

        battery = {
          appname = "Power Warning";
        };

        volume-muted = {
          summary = "Volume muted";
          highlight = "#e05f65";
        };
      };
    };
    home.packages = [ pkgs.libnotify ];
  };
}
