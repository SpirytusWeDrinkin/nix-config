{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    installBatSyntax = true;
    settings = {
      theme = "catppuccin-macchiato";
      font-size = 14;
      font-family = "IosevkaTerm Nerd Font";
      font-style = "Bold";
      window-decoration = "none";
      window-padding-x = 5;
      window-padding-y = 5;
      resize-overlay = "never";
      confirm-close-surface = false;
      background-opacity = 0.85;
      gtk-titlebar = false;
      window-inherit-working-directory = "false";
      working-directory = "home";
      keybind = [
        "ctrl+enter=unbind"
      ];
    };
    themes = {
      catppuccin-macchiato = {
        palette = [
          "0=#494d64"
          "1=#ed8796"
          "2=#a6da95"
          "3=#eed49f"
          "4=#8aadf4"
          "5=#f5bde6"
          "6=#8bd5ca"
          "7=#a5adcb"
          "8=#5b6078"
          "9=#ed8796"
          "10=#a6da95"
          "11=#eed49f"
          "12=#8aadf4"
          "13=#f5bde6"
          "14=#8bd5ca"
          "15=#b8c0e0"
        ];
        background = "24273a";
        foreground = "cad3f5";
        cursor-color = "f4dbd6";
        cursor-text = "181926";
        selection-background = "3a3e53";
        selection-foreground = "cad3f5";
      };
    };
  };
}
