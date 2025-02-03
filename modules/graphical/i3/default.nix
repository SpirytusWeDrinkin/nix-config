{ inputs, pkgs, lib, config, ... }:
with lib;
let
  cfg = config.graphical.i3;
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

  bemenu-command = ''
    bemenu-run \
    --ab '#24273a' \
    --af '#cad3f5' \
    --fb '#24273a' \
    --ff '#cad3f5' \
    --hb '#24273a' \
    --hf '#eed49f' \
    --nb '#24273a' \
    --nf '#cad3f5' \
    --tb '#24273a' \
    --tf '#ed8796' \
    --binding vim \
    --cw 15 \
    --fn 'IosevkaTerm Nerd Font 14' \
    --hp 10 \
    --ignorecase \
    --line-height 42 \
    --prompt '  ' \
    --vim-esc-exits \
    --wrap
  '';
in {
  options.graphical.i3 = {
    enable = mkEnableOption "i3";

    wallpaper = mkOption {
      type = types.nullOr types.path;
      description = "Wallpaper for i3";
      default = null;
    };
    lockscreen = mkOption {
      type = types.nullOr types.path;
      description = "Wallpaper for i3lock";
      default = null;
    };
    barCmd = mkOption {
      type = types.str;
      description = "Command for launching the bar";
      default = "";
    };
  };
  config = mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        startup = [
          {
            command = "dex --autostart --environment i3";
            notification = false;
          }
          {
            command = "autotiling";
            notification = false;
            always = true;
          }
          {
            command = "feh --bg-fill ${cfg.wallpaper}";
            always = true;
            notification = false;
          }
          {
            command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
            always = true;
            notification = false;
          }
          {
            command = "setxkbmap us intl";
            always = true;
            notification = false;
          }
          {
            command = cfg.barCmd;
            always = true;
          }
          {
            command = "picom -b";
            always = true;
            notification = false;
          }
          {
            command = "dunst";
            always = true;
            notification = false;
          }
        ];
        keybindings = lib.mkOptionDefault {
          "${modifier}+Return" = "exec i3-sensible-terminal";
          "${modifier}+q" = "kill";
          "${modifier}+d" = "exec ${bemenu-command}";
          "${modifier}+x" = "exec i3lock -i ${cfg.wallpaper}";
          "${modifier}+s" = "exec maim -s | xclip -selection clipboard -t image/png";
        };
        gaps = {
          outer = 5;
          inner = 6;
        };
        bars = [
          /* {
            position = "top";
            trayOutput = "primary";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";

            fonts = {
              names = [ "pango:IosevkaTerm Nerd Font" ];
              style = "Bold";
              size = 11.0;
            };

            colors = {
              background = "#${my_colors.base}";
              statusline = "#${my_colors.text}";
              focusedStatusline = "#${my_colors.text}";
              focusedSeparator = "#${my_colors.base}";

              focusedWorkspace = {
                border = "#${my_colors.base}";
                background = "#${my_colors.mauve}";
                text = "#${my_colors.crust}";
              };
              activeWorkspace = {
                border = "#${my_colors.base}";
                background = "#${my_colors.surface2}";
                text = "#${my_colors.text}";
              };
              inactiveWorkspace = {
                border = "#${my_colors.base}";
                background = "#${my_colors.base}";
                text = "#${my_colors.text}";
              };
              urgentWorkspace = {
                border = "#${my_colors.base}";
                background = "#${my_colors.red}";
                text = "#${my_colors.crust}";
              };
            };
          } */
        ];
        window.border = 3;
        window.titlebar = false;
        floating.border = 1;
        colors = {
          focused = {
            background = "#${my_colors.base}";
            border = "#${my_colors.lavender}";
            childBorder = "#${my_colors.lavender}";
            indicator = "#${my_colors.rosewater}";
            text = "#${my_colors.text}";
          };
          focusedInactive = {
            childBorder = "#${my_colors.overlay0}";
            background = "#${my_colors.base}";
            indicator = "#${my_colors.rosewater}";
            border = "#${my_colors.overlay0}";
            text = "#${my_colors.text}";
          };
          unfocused = {
            childBorder = "#${my_colors.overlay0}";
            background = "#${my_colors.base}";
            text = "#${my_colors.text}";
            indicator = "#${my_colors.rosewater}";
            border = "#${my_colors.overlay0}";
          };
          urgent = {
            childBorder = "#${my_colors.peach}";
            background = "#${my_colors.base}";
            text = "$#{my_colors.peach}";
            indicator = "#${my_colors.overlay0}";
            border = "#${my_colors.peach}";
          };
          placeholder = {
            childBorder = "#${my_colors.overlay0}";
            background = "#${my_colors.base}";
            text = "#${my_colors.text}";
            indicator = "#${my_colors.overlay0}";
            border = "#${my_colors.overlay0}";
          };
          background = "#${my_colors.base}";
        };
        focus = {
          followMouse = false;
        };
      };
    };
    services.picom = {
      package = pkgs.picom-pijulius;
      enable = true;
    };
    home.packages = with pkgs; [ pango autotiling maim xclip ];
    home.pointerCursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
      x11.enable = true;
    };
  };
}
