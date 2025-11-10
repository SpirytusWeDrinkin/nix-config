{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python3Packages.adblock
  ];

  programs.qutebrowser = {
    enable = true;

    greasemonkey = [
      (pkgs.writeTextFile {
        name = "youtube-freedom.js";
        text = builtins.readFile ./greasemonkey/youtube-freedom.js;
      })
    ];

    settings = {
      content.autoplay = false;
      content.pdfjs = true;

      content.blocking.enabled = true;
      content.blocking.method = "both";
      content.javascript.enabled = true;

      content.user_stylesheets = [
        "${./style/youtube.css}"
      ];

      content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt"
        "https://easylist.to/easylist/easyprivacy.txt"

        "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.plus.txt"
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"

        "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"

        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt"
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt"
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt"
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt"
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt"
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt"

        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt"
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt"
      ];

      content.javascript.can_open_tabs_automatically = true;
      content.javascript.clipboard = "access";

      auto_save.session = true;

      completion.timestamp_format = "%Y-%m-%d %H:%M";
      completion.height = "50%";
      completion.show = "always";
      completion.shrink = true;
      completion.quick = true;
      completion.open_categories = [
        "searchengines"
        "quickmarks"
        "bookmarks"
        "history"
        "filesystem"
      ];

      history_gap_interval = 30;

      session.lazy_restore = true;

      downloads.position = "bottom";
      downloads.remove_finished = 10000;

      fonts.default_family = "Iosevka Nerd Font";
      fonts.default_size = "11pt";

      colors = {
        completion.fg = "#cad3f5";
        completion.odd.bg = "#1e2030";
        completion.even.bg = "#1e2030";
        completion.category.fg = "#a6da95";
        completion.category.bg = "#24273a";
        completion.category.border.top = "#939ab7";
        completion.category.border.bottom = "#24273a";
        completion.item.selected.fg = "#cad3f5";
        completion.item.selected.bg = "#5b6078";
        completion.item.selected.border.top = "#5b6078";
        completion.item.selected.border.bottom = "#5b6078";
        completion.item.selected.match.fg = "#f4dbd6";
        completion.match.fg = "#cad3f5";
        completion.scrollbar.fg = "#5b6078";
        completion.scrollbar.bg = "#181926";

        statusbar.normal.fg = "#cad3f5";
        statusbar.normal.bg = "#24273a";
        statusbar.insert.fg = "#f4dbd6";
        statusbar.insert.bg = "#181926";
        statusbar.passthrough.fg = "#f5a97f";
        statusbar.passthrough.bg = "#24273a";
        statusbar.private.fg = "#a5adcb";
        statusbar.private.bg = "#1e2030";
        statusbar.command.fg = "#cad3f5";
        statusbar.command.bg = "#24273a";
        statusbar.command.private.fg = "#a5adcb";
        statusbar.command.private.bg = "#24273a";
        statusbar.caret.fg = "#f5a97f";
        statusbar.caret.bg = "#24273a";
        statusbar.caret.selection.fg = "#f5a97f";
        statusbar.caret.selection.bg = "#24273a";
        statusbar.progress.bg = "#24273a";
        statusbar.url.fg = "#cad3f5";
        statusbar.url.error.fg = "#ed8796";
        statusbar.url.hover.fg = "#91d7e3";
        statusbar.url.success.http.fg = "#8bd5ca";
        statusbar.url.success.https.fg = "#a6da95";
        statusbar.url.warn.fg = "#eed49f";

        tabs.bar.bg = "#181926";
        tabs.indicator.start = "#8aadf4";
        tabs.indicator.stop = "#a6da95";
        tabs.indicator.error = "#ed8796";
        tabs.odd.fg = "#939ab7";
        tabs.odd.bg = "#494d64";
        tabs.even.fg = "#939ab7";
        tabs.even.bg = "#5b6078";
        tabs.selected.odd.fg = "#cad3f5";
        tabs.selected.odd.bg = "#24273a";
        tabs.selected.even.fg = "#cad3f5";
        tabs.selected.even.bg = "#24273a";
        tabs.pinned.even.bg = "#363a4f";
        tabs.pinned.even.fg = "#cad3f5";
        tabs.pinned.odd.bg = "#363a4f";
        tabs.pinned.odd.fg = "#cad3f5";
        tabs.pinned.selected.even.bg = "#24273a";
        tabs.pinned.selected.even.fg = "#cad3f5";
        tabs.pinned.selected.odd.bg = "#24273a";
        tabs.pinned.selected.odd.fg = "#cad3f5";

        hints.fg = "#1e2030";
        hints.bg = "#f5a97f";
        hints.match.fg = "#b8c0e0";

        downloads.bar.bg = "#24273a";
        downloads.start.fg = "#24273a";
        downloads.start.bg = "#8aadf4";
        downloads.stop.fg = "#24273a";
        downloads.stop.bg = "#a6da95";
        downloads.error.fg = "#ed8796";

        messages.error.fg = "#ed8796";
        messages.error.bg = "#6e738d";
        messages.error.border = "#1e2030";
        messages.warning.fg = "#f5a97f";
        messages.warning.bg = "#6e738d";
        messages.warning.border = "#1e2030";
        messages.info.fg = "#cad3f5";
        messages.info.bg = "#6e738d";
        messages.info.border = "#1e2030";

        prompts.fg = "#cad3f5";
        prompts.bg = "#1e2030";
        prompts.selected.fg = "#f4dbd6";
        prompts.selected.bg = "#5b6078";

        contextmenu.disabled.bg = "#1e2030";
        contextmenu.disabled.fg = "#6e738d";
        contextmenu.menu.bg = "#24273a";
        contextmenu.menu.fg = "#cad3f5";
        contextmenu.selected.bg = "#6e738d";
        contextmenu.selected.fg = "#f4dbd6";

        keyhint.fg = "#cad3f5";
        keyhint.bg = "#1e2030";
        keyhint.suffix.fg = "#b8c0e0";

        webpage.bg = "#24273a";
        webpage.preferred_color_scheme = "dark";

        prompts.border = "1px solid #6e738d";
        tabs.indicator.system = "none";
      };

      hints.border = "1px solid #1e2030";
    };

    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      "!g" = "https://www.google.com/search?q={}";
      "!gh" = "https://github.com/search?q={}";
      "!yt" = "https://www.youtube.com/results?search_query={}";
      "!wiki" = "https://en.wikipedia.org/wiki/{}";
      "!reddit" = "https://www.reddit.com/search?q={}";
      "!nix" = "https://search.nixos.org/packages?query={}";
      "!nixopt" = "https://search.nixos.org/options?query={}";
      "!claude" = "https://claude.ai/new?q={}";
      "!maps" = "https://www.google.com/maps/search/{}";
      "!translate" = "https://translate.google.com/?sl=auto&tl=en&text={}";
    };

    quickmarks = {
      yt = "https://www.youtube.com";
      gh = "https://github.com";
      reddit = "https://www.reddit.com";
      claude = "https://claude.ai";
      mail = "https://mail.google.com";
      drive = "https://drive.google.com";
      calendar = "https://calendar.google.com";
      nixpkgs = "https://search.nixos.org/packages";
      nixopts = "https://search.nixos.org/options";
      hm = "https://nix-community.github.io/home-manager/options.xhtml";
    };

    keyBindings = {
      normal = {
        "<Ctrl-Shift-j>" = "tab-move +";
        "<Ctrl-Shift-k>" = "tab-move -";
        "M" = "spawn mpv {url}";
        "m" = "hint links spawn mpv {hint-url}";
      };
    };
  };
}
