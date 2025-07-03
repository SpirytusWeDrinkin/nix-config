_: {
  programs.i3status-rust = {
    enable = true;
    bars.default = {
      blocks = [
        {
          block = "load";
          format = "<span background='#b08500'>    </span><span background='#bfbaac'>  %5min Load  </span>";
        }
        {
          block = "cpu_temperature 0";
          format = "<span background='#d12f2c'>    </span><span background='#bfbaac'>  %degrees °C  </span>";
          path = "/sys/class/thermal/thermal_zone0/temp";
        }
        {
          block = "volume master";
          format = "<span background='#696ebf'>    </span><span background='#bfbaac'>  %volume  </span>";
          format_muted = "<span background='#696ebf'>    </span><span background='#bfbaac'>  Muted  </span>";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        }
        {
          block = "time";
          format = "<span background='#2587cc'>    </span><span background='#bfbaac'>  %b %d at %H:%M  </span>";
        }
      ];
    };
  };
}
