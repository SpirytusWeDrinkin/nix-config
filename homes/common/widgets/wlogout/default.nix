{ pkgs, config, ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "${pkgs.swaylock}/bin/swaylock -i ${config.windowManager.lockscreen} --indicator-radius 100";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "sleep 1; systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "sleep 1; pkill maomao";
        text = "Exit";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "sleep 1; systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "sleep 1; systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
      ${builtins.readFile ./config/style.css}
      #lock {
        background-image: url("${./config/icons/lock.svg}");
      }
      #logout {
        background-image: url("${./config/icons/logout.svg}");
      }
      #suspend {
        background-image: url("${./config/icons/suspend.svg}");
      }
      #hibernate {
        background-image: url("${./config/icons/hibernate.svg}");
      }
      #shutdown {
        background-image: url("${./config/icons/shutdown.svg}");
      }
      #reboot {
        background-image: url("${./config/icons/reboot.svg}");
      }
    '';
  };
}
