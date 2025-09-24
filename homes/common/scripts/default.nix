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

        shell = pkgs.writeScript "shell" ''
          #!${pkgs.bash}/bin/bash
          if [ "$#" -eq 0 ]; then
            echo "Usage: $0 pkg1 pkg2 pkg3 ..."
            exit 1
          fi

          pkgs=""
          for pkg in "$@"; do
            pkgs="$pkgs nixpkgs#$pkg"
          done

          exec nix shell $pkgs --command zsh
        '';
      };
    })
  ];
}
