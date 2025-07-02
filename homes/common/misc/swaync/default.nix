_: {
  services.swaync = {
    enable = true;
    settings = {
      # General settings
      image-visibility = "when-available";
      keyboard-shortcut = true;
      relative-timestamps = true;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      script-fail-notify = true;
      transition-time = 200;
      # Layer settings
      layer = "overlay";
      # Notification settings
      positionX = "right";
      positionY = "top";
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-window-width = 440;
      # Control center settings
      control-center-positionX = "right";
      control-center-positionY = "top";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-left = 10;
      control-center-margin-right = 10;
      control-center-width = 500;
      control-center-height = 800;
      fit-to-screen = false;
      hide-on-action = true;
      hide-on-clear = true;
      # Widget settings
      widgets = [
        "title"
        "dnd"
        "mpris"
        "notifications"
      ];
      # Widget config
      widget-config = {
        title = {
          text = "Swaync";
          clear-all-button = true;
          button-text = "󰩺 Clear";
        };
        dnd = {
          text = "  Do Not Disturb";
        };
        label = {
          max-line = 1;
          text = "󰂚  Control Center";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
          blur = true;
        };
      };
    };
    # Custom style
    style = builtins.readFile ./config/style.css;
  };
}
