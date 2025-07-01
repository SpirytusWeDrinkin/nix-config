{
  pkgs,
  config,
  inputs,
  ...
}:
let
  bemenu-command = "${pkgs.bemenu}/bin/bemenu-run --ab '##24273a' --af '##cad3f5' --fb '##24273a' --ff '##cad3f5' --hb '##24273a' --hf '##eed49f' --nb '##24273a' --nf '##cad3f5' --tb '##24273a' --tf '##ed8796' --binding vim --cw 15 --fn 'IosevkaTerm Nerd Font 14' --hp 10 --ignorecase --line-height 42 --prompt '  ' --vim-esc-exits --wrap";
in
{
  imports = [
    inputs.maomaowm.hmModules.maomaowm
  ];
  wayland.windowManager.maomaowm = {
    enable = true;
    autostart_sh = ''
      ${pkgs.swww}/bin/swww-daemon
      ${pkgs.swww}/bin/swww ${config.windowManager.wallpaper}
      ${pkgs.waybar}/bin/waybar
    '';
    settings = ''
      # More option see https://github.com/DreamMaoMao/maomaowm/wiki/

      bind=SUPER,d,spawn,bemenu-run
      bind=SUPER,Return,spawn,${pkgs.ghostty}/bin/ghostty

      ${builtins.readFile ./config/bind.conf}
      ${builtins.readFile ./config/config.conf}
      ${builtins.readFile ./config/env.conf}
    '';
  };

}
