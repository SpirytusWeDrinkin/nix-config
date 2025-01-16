{ config, lib, ... }:
with lib;
let
  cfg = config.abelc.waybar;
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
  options.abelc.waybar = { enable = mkEnableOption "waybar"; };
  config = mkIf cfg.enable {
    programs.waybar.enable = true;
    programs.waybar.settings = {
      mainBar = {
        layer = "top";

        modules-left = [
          "custom/launcher"
          "clock"
          "network"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "cpu"
          "memory"
          "battery"
          "custom/power"
        ];

        pulseaudio = {
          tooltip = false;
          scroll-step = 2;
          format = "{icon} {volume}%";
          format-muted = "{icon} {volume}%";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          format-icons = {
            default = [
              " "
              " "
              " "
            ];
          };
        };

        "hyprland/workspaces" = {
          active-only = false;
          all-output = true;
          on-click = true;
          format = "{icon}";
          format-icons = {
            urgent = "󰵚 ";
            active = "󰝥 ";
            default = " ";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };

        network = {
          tooltip = false;
          format-wifi = "  {essid}";
          format-ethernet = "󰈀 ";
        };

        backlight = {
          device = "amdgpu_bl2";
          format = "󰉄 {percent}%";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
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
        };

        cpu = {
          interval = 15;
          format = "󰍛  {}%";
          max-length = 10;
        };

        memory = {
          interval = 30;
          format = "  {}%";
          max-length = 10;
        };

        "custom/launcher" = {
          format = " ";
          on-click = "rofi -show drun";
          on-click-right = "killall rofi";
        };
        "custom/power" = {
          format = " ";
          on-click = "bash ~/.config/rofi/leave.sh";
        };
      };
    };
    # stylix.targets.waybar.enable = false;
    programs.waybar.style = ''
              * {
      border: none;
              border-radius: 10px;
              font-family: "IosevkaTerm Nerd Font";
              font-weight: bold;
              font-size: 15px;
              min-height: 10px;
              }

          window#waybar {
      background: transparent;
          }

          window#waybar.hidden {
      opacity: 0.2;
          }

      #window {
          margin-top: 6px;
          padding-left: 10px;
          padding-right: 10px;
          border-radius: 10px;
      transition: none;
      color: transparent;
      background: transparent;
      }

      #workspaces {
          margin-top: 6px;
          margin-left: 12px;
          font-size: 4px;
          margin-bottom: 0px;
          border-radius: 10px;
      background: #${colors.base};
      transition: none;
      }

      #workspaces button {
      padding: 1px 9px;
      margin: 3px 3px;
              border-radius: 15px;
      border:0px;
      color: #${colors.overlay2};
      background: #${colors.base};
      transition: all 0.3s ease-in-out;
      opacity:0.4;
      }

      #workspaces button.active {
      color: #${colors.yellow};
      background: transparent;
                  border-radius: 15px;
                  min-width: 30px;
      transition: all 0.3s ease-in-out;
      opacity:1.0;

      }

      #workspaces button:hover {
      transition: none;
                  box-shadow: inherit;
                  text-shadow: inherit;
      color: #${colors.yellow};
      }

      #network {
          margin-top: 6px;
          margin-left: 8px;
          padding-left: 10px;
          padding-right: 10px;
          margin-bottom: 0px;
          border-radius: 10px;
      transition: none;
      color: #${colors.lavender};
      background: #${colors.base};
      }

      #pulseaudio {
          margin-top: 6px;
          margin-left: 8px;
          padding-left: 10px;
          padding-right: 10px;
          margin-bottom: 0px;
          border-radius: 10px;
      transition: none;
      color: #${colors.mauve};
      background: #${colors.base};
      }

      #backlight {
          margin-top: 6px;
          margin-left: 8px;
          padding-left: 10px;
          padding-right: 10px;
          margin-bottom: 0px;
          border-radius: 10px;
      transition: none;
      color: #${colors.peach};
      background: #${colors.base};
      }

      #battery {
          margin-top: 6px;
          margin-left: 8px;
          padding-left: 10px;
          padding-right: 10px;
          margin-bottom: 0px;
          border-radius: 10px;
      transition: none;
      color: #${colors.green};
      background: #${colors.base};
      }

      #battery.charging, #battery.plugged {
      color: #${colors.teal};
      background: #${colors.base};
      }

      #battery.critical:not(.charging) {
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      color: #${colors.text};
      background: #${colors.red};
      }


      #clock {
          margin-top: 6px;
          margin-left: 8px;
          padding-left: 10px;
          padding-right: 10px;
          margin-bottom: 0px;
          border-radius: 10px;
      transition: none;
      color: #${colors.teal};
      background: #${colors.base};
      }

      #memory {
          margin-top: 6px;
          margin-left: 8px;
          padding-left: 10px;
          margin-bottom: 0px;
          padding-right: 10px;
          border-radius: 10px;
      transition: none;
      color: #${colors.yellow};
      background: #${colors.base};
      }

      #cpu {
          margin-top: 6px;
          margin-left: 8px;
          padding-left: 10px;
          margin-bottom: 0px;
          padding-right: 10px;
          border-radius: 10px;
      transition: none;
      color: #${colors.maroon};
      background: #${colors.base};
      }

      #custom-launcher {
          font-size: 24px;
          margin-top: 6px;
          margin-left: 8px;
          padding-left: 5px;
          padding-right: 5px;
          border-radius: 10px;
      transition: none;
      background: #7EBAE4;
      color: #5277C3;
      }

      #custom-power {
          font-size: 20px;
          margin-top: 6px;
          margin-left: 8px;
          margin-right: 5px;
          padding-left: 7px;
          padding-right: 5px;
          margin-bottom: 0px;
          border-radius: 10px;
      transition: none;
      color: #${colors.maroon};
      background: #${colors.base};
      }
    '';
  };
}
