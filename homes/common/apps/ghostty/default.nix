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
    };
  };
}
