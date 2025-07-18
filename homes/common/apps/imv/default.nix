_: {
  programs.imv = {
    enable = true;
    settings = {
      options = {
        background = "24273a";
        fullscreen = false;
        width = 1400;
        height = 900;
        initial_pan = "0.5x0.5";
        scaling_mode = "shrink";
        recursive = true;
        list_files_at_exit = false;
        loop_input = true;
        title_text = "imv - $imv_current_file [$imv_current_index/$imv_file_count] - $imv_width×$imv_height";
        overlay = true;
        overlay_text_color = "cad3f5";
        overlay_text_alpha = "aa";
        overlay_background_color = "1e2030";
        overlay_font = "Iosevka Nerd Font:14";
        overlay_text = "$imv_current_file [$imv_current_index/$imv_file_count] $imv_width×$imv_height $imv_scale%";
        slideshow_duration = 3;
        suppress_default_binds = false;
      };

      aliases = {
        x = "close";
        q = "quit";
        reload = "exec imv $imv_current_file";
        trash = "exec trash-put $imv_current_file; close";
        edit = "exec gimp $imv_current_file &";
        copy_path = "exec wl-copy $imv_current_file";
        copy_image = "exec wl-copy < $imv_current_file";
        set_wallpaper = "exec swaybg -i $imv_current_file -m fill";
        open_folder = "exec nautilus $(dirname $imv_current_file)";
        info = "exec identify $imv_current_file";
      };

      binds = {
        "q" = "quit";
        "<Escape>" = "quit";
        "x" = "close";
        "<Left>" = "prev";
        "<Right>" = "next";
        "j" = "next";
        "k" = "prev";
        "<space>" = "next";
        "<BackSpace>" = "prev";
        "h" = "prev";
        "l" = "next";
        "gg" = "goto 1";
        "<Shift+G>" = "goto -1";
        "<Home>" = "goto 1";
        "<End>" = "goto -1";
        "<Shift+W>" =
          "exec imv $(find $(dirname $imv_current_file) -type f -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.gif' -o -name '*.webp' | shuf -n 1)";
        "<Ctrl+plus>" = "zoom 1.2";
        "<Ctrl+equal>" = "zoom 1.2";
        "<Ctrl+minus>" = "zoom 0.8";
        "<Ctrl+0>" = "zoom actual";
        "<Ctrl+9>" = "zoom optimal";
        "z" = "zoom optimal";
        "Z" = "zoom actual";
        "<Shift+J>" = "pan 0 50";
        "<Shift+K>" = "pan 0 -50";
        "<Shift+H>" = "pan -50 0";
        "<Shift+L>" = "pan 50 0";
        "<Down>" = "pan 0 50";
        "<Up>" = "pan 0 -50";
        "<Shift+Left>" = "pan -50 0";
        "<Shift+Right>" = "pan 50 0";
        "c" = "center";
        "f" = "fullscreen";
        "<F11>" = "fullscreen";
        "r" = "rotate by 90";
        "<Shift+R>" = "rotate by -90";
        "m" = "flip horizontal";
        "<Shift+M>" = "flip vertical";
        "s" = "scaling_mode next";
        "<Shift+S>" = "slideshow";
        "o" = "overlay";
        "d" = "trash";
        "<Delete>" = "trash";
        "<Shift+Delete>" = "exec rm $imv_current_file; close";
        "<Ctrl+c>" = "copy_path";
        "<Ctrl+Shift+c>" = "copy_image";
        "<Return>" = "edit";
        "e" = "edit";
        "<Ctrl+o>" = "open_folder";
        "i" = "info";
        "<Ctrl+i>" = "exec echo '$imv_current_file: $imv_width×$imv_height, $imv_scale%' | imv-msg";
        "w" = "set_wallpaper";
        "<Ctrl+r>" = "relaod";
        "<F5>" = "reload";
        "p" = "exec echo $imv_current_file";
        "<Page_Up>" = "next 10";
        "<Page_Down>" = "prev 10";
        "<MouseLeft>" = "drag";
        "<MouseRight>" = "next";
        "<MouseMiddle>" = "prev";
        "<ScrollUp>" = "zoom 1.1";
        "<ScrollDown>" = "zoom 0.9";
        "<Shift+ScrollUp>" = "prev";
        "<Shift+ScrollDown>" = "next";
        "<Ctrl+ScrollUp>" = "pan 0 -30";
        "<Ctrl+ScrollDown>" = "pan 0 30";
        "1" = "goto 1";
        "2" = "next 2";
        "3" = "next 3";
        "4" = "next 4";
        "5" = "next 5";
        "6" = "next 6";
        "7" = "next 7";
        "8" = "next 8";
        "9" = "next 9";
        "0" = "goto -1";
        "<Ctrl+f>" =
          "exec imv $(find $(dirname $imv_current_file) -type f \\( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.gif' -o -name '*.webp' -o -name '*.bmp' -o -name '*.tiff' \\) | fzf)";
        "<Ctrl+g>" =
          "exec imv $(find ~/Pictures -type f \\( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.gif' -o -name '*.webp' \\) | fzf)";
        "<Ctrl+s>" = "slideshow";
        "<Ctrl+Shift+s>" = "exec imv -s 5 $(dirname $imv_current_file)/*";
        "<Ctrl+q>" = "quit";
        "<F1>" =
          "exec echo 'IMV Keybindings: q=quit, j/k=next/prev, f=fullscreen, r=rotate, s=scale, d=delete, w=wallpaper, i=info, e=edit' | imv-msg";
      };
    };
  };
}
