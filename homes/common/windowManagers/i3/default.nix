{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
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
in
{
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
          command = "feh --bg-fill ${config.windowManager.wallpaper}";
          always = true;
          notification = false;
        }
        {
          command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
          always = true;
          notification = false;
        }
        {
          command = "setxkbmap us intl -option ctlr:nocaps";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.polybar}/bin/polybar";
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
        "${modifier}+Return" = "${config.windowManager.terminal}";
        "${modifier}+q" = "kill";
        "${modifier}+d" = "exec ${bemenu-command}";
        "${modifier}+x" = "exec i3lock -i ${config.windowManager.lockscreen}";
        "${modifier}+s" = "${pkgs.my-scripts.screenshot}";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
      };
      gaps = {
        outer = 5;
        inner = 6;
      };
      bars = [
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
    enable = true;
    package = pkgs.picom;

    backend = "glx";
    vSync = true;

    fade = true;
    fadeDelta = 3;

    shadow = true;

    settings = {
      daemon = true;
      use-damage = false;
      corner-radius = 5;
      round-borders = 5;

      animations = true;
      animation-window-mass = 0.5;
      animation-for-open-window = "zoom";
      animation-stiffness = 350;
      animation-clamping = false;
      fade-out-step = 1;

      detect-rounded-corners = true;
      detect-client-opacity = false;
      detect-transient = true;
      detect-client-leader = false;
      mark-wmwim-focused = true;
      mark-ovredir-focues = true;
      unredir-if-possible = true;

      blur = {
        method = "dual_kawase";
        strength = 1;
        kern = "3x3box";
        background = false;
        background-frame = false;
      };
    };
  };
  home.packages = with pkgs; [
    pango
    autotiling
    maim
    xclip
  ];
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    x11.enable = true;
  };
}
