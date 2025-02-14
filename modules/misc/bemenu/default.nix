{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.misc.bemenu;
in {
  options.misc.bemenu = {enable = mkEnableOption "bemenu";};
  config = mkIf cfg.enable {
    programs.bemenu = {
      enable = true;
      settings = {
        line-height = 38;
        prompt = "  ";
        ignorecase = true;
        binding = "vim";
        vim-esc-exits = true;
        cw = 15;
        hp = 10;
        wrap = true;
        fn = "IosevkaTerm Nerd Font 14";

        fb = "#24273a";
        ff = "#cad3f5";
        nb = "#24273a";
        nf = "#cad3f5";
        tb = "#24273a";
        hb = "#24273a";
        tf = "#ed8796";
        hf = "#eed49f";
        af = "#cad3f5";
        ab = "#24273a";
      };
    };
  };
}
