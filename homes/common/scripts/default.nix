{ pkgs, ... }:
let

in
{
  nixpkgs.overlays = [
    (final: prev: {
      my-scripts = {
        wlr-monitor-switch = pkgs.writeScript "monitors-switch" ''
          #!${pkgs.bash}/bin/bash

          enable=$(${pkgs.wlr-randr}/bin/wlr-randr --json | ${pkgs.jq}/bin/jq --arg name "eDP-1" '.[] | select(.name == $name) | .enabled')
          if [ $enable == "true" ]; then
              ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --off &
          else
              ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --on &
          fi
        '';

        screenshot = pkgs.writeScript "screenshot" ''
          #!${pkgs.bash}/bin/bash
          ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -b '#41455955' -c '#ca9ee6')" -t ppm - | \
            ${pkgs.satty}/bin/satty -f -
        '';
      };
    })
  ];
}
