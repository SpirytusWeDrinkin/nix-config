_: {
  programs.btop = {
    enable = true;
    settings = {
      # Use Catppuccin theme
      color_theme = "catppuccin_macchiato";
      theme_background = false;

      # Interface
      vim_keys = true;
      rounded_corners = true;
      graph_symbol = "braille";

      # Layout
      shown_boxes = "cpu mem net proc";
      update_ms = 2000;

      # Process settings
      proc_sorting = "cpu lazy";
      proc_colors = true;
      proc_mem_bytes = true;

      # System monitoring
      show_temperature = true;
      check_temp = true;
      temp_scale = "celsius";
      show_swap = true;
      show_disks = true;
      show_io_stat = true;
      show_battery = true;

      # Network
      net_auto = true;
      net_sync = true;

      # Clock
      draw_clock = "%X";
      background_update = true;

      # Logging
      log_level = "WARNING";
    };
    themes = {
      catppuccin_macchiato = builtins.readFile ./config/catppuccin_macchiato.theme;
    };
  };
}
