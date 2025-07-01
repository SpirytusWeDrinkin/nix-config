{
  pkgs,
  lib,
  config,
  ...
}:
let
  bemenu-command = "${pkgs.bemenu}/bin/bemenu-run --ab '##24273a' --af '##cad3f5' --fb '##24273a' --ff '##cad3f5' --hb '##24273a' --hf '##eed49f' --nb '##24273a' --nf '##cad3f5' --tb '##24273a' --tf '##ed8796' --binding vim --cw 15 --fn 'IosevkaTerm Nerd Font 14' --hp 10 --ignorecase --line-height 42 --prompt '  ' --vim-esc-exits --wrap";
in
{
  wayland.windowManager.maomaowm = {
    enable = true;
  };
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-fancy;
  };
}
