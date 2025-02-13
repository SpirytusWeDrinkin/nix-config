{ inputs, pkgs, lib, config, ... }:
with lib;
let
  cfg = config.abelc.hyprland;
  bemenu-command = "${pkgs.bemenu}/bin/bemenu-run --ab '##24273a' --af '##cad3f5' --fb '##24273a' --ff '##cad3f5' --hb '##24273a' --hf '##eed49f' --nb '##24273a' --nf '##cad3f5' --tb '##24273a' --tf '##ed8796' --binding vim --cw 15 --fn 'IosevkaTerm Nerd Font 14' --hp 10 --ignorecase --line-height 42 --prompt '  ' --vim-esc-exits --wrap";
in
{
  options.graphical.hyprland = {
    enable = mkEnableOption "hyprland";

    wallpaper = mkOption {
      type = types.nullOr types.path;
      description = "Wallpaper for hyprland";
      default = null;
    };
  };
  config = mkIf cfg.enable
  {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = false;
      xwayland.enable = true;
      settings = {
        exec-once = [
            "waybar"
            "hyprctl setcursor Bibata-Modern-Ice 24"
            "hyprpaper"
          ];
        # Environment variables
        env = [
          # Enable Ozone support for NixOS
          "NIXOS_OZONE_WL, 1"

          # Allow unfree packages in Nixpkgs
          "NIXPKGS_ALLOW_UNFREE, 1"

          # Set the current desktop environment to Hyprland
          "XDG_CURRENT_DESKTOP, Hyprland"

          # Set the session type to Wayland
          "XDG_SESSION_TYPE, wayland"

          # Set the GDK backend to Wayland and X11
          "GDK_BACKEND, wayland, x11"

          # Set the Qt platform to Wayland and XCB
          "QT_QPA_PLATFORM=wayland;xcb"

          # Disable window decoration in Qt for Wayland
          "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

          # Enable automatic screen scale factor in Qt
          "QT_AUTO_SCREEN_SCALE_FACTOR, 1"

          # Set the SDL video driver to X11
          "SDL_VIDEODRIVER, x11"

          # Enable Wayland support in Mozilla applications
          "MOZ_ENABLE_WAYLAND, 1"

          #NVIDIA
          "LIBVA_DRIVER_NAME, nvidia"
          "__GLX_VENDOR_LIBRARY_NAME, nvidia"
        ];

        #Binds
        "$mod" = "SUPER";
        bind = [
          # Launch terminal
          "$mod, Return, exec, alacritty"

          # Window management
          "$mod, Q, killactive"
          "$mod, M, exit"
          "$mod, E, exec, alacritty --class floating -e ranger"
          "$mod, V, togglefloating"
          "$mod, F, fullscreen"
          "$mod, D, exec, ${bemenu-command}"
          "$mod, X, exec, ${pkgs.swaylock-fancy}/bin/swaylock-fancy"
          "ALT, Tab, exec, rofi -show window"
          # "$mod, P, exec, sh ~/.config/rofi/leave.sh"
          "$mod, J, togglesplit"
          "$mod, S, exec, grim -g \"$(slurp)\" - | wl-copy"

          # Move focus with arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

        ]
        ++ (
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          10))
        ++ (
        builtins.concatLists (builtins.genList (i:
            let ws = i + 6;
            in [
              "$ALT, code:1${toString i}, workspace, ${toString ws}"
              "$ALT SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          5));

        workspace = [
          ]
          ++ (builtins.concatLists (builtins.genList (i:
            let ws = i+1;
            in [
                "${toString ws}, monitor:eDP-1"
              ]
            )
            5))
          ++ (builtins.concatLists (builtins.genList (i:
            let ws = i+6;
            in [
                "${toString ws}, monitor:HDMI-A-1"
              ]
            )
            5));

        bindm = [
          # Move/resize windows with mouse
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        input = {
          follow_mouse = false;
          touchpad = {
            natural_scroll = "yes";
            scroll_factor = 0.3;
          };
          # sensitivity = 1;  # Commented out as -1.0 - 1.0 range
          kb_layout = "us";
          kb_variant = "intl";
        };

        # xwayland options
        xwayland.force_zero_scaling = true;
        monitor = [
            "eDP-1, highrr, 0x0, 2"
            ", preferred, 1920x0, 1"
          ];

        # General options
        general = {
          gaps_in = 5;
          gaps_out = 8;
          border_size = 2;
          layout = "dwindle";
          "col.active_border" = "rgb(c6a0f6)";
          "col.inactive_border" = "rgb(1e2030)";
        };

        # Decoration options
        decoration = {
          rounding = 5;
          blur = {
            enabled = true;
            size = 4;
            passes = 2;
          };
        };

        # Animation options
        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 6, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # Dwindle layout options
        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        # Gesture options
        gestures = {
          workspace_swipe = "on";
        };
      };
    };
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-fancy;
    };
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ cfg.wallpaper ];
        wallpaper = [
          ", ${cfg.wallpaper}"
        ];
      };
    };
  };
}
