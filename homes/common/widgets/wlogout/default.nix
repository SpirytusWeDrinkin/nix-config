_: {
  programs.wlogout = {
    enable = true;
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
