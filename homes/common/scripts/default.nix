{ pkgs, ... }:
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

        monitor-manager = pkgs.writeScriptBin "monitor-manager" ''
          #!${pkgs.bash}/bin/bash

          CONFIG_DIR="$HOME/.local/state/maomao"
          CONFIG_FILE="$CONFIG_DIR/monitor.conf"

          BEMENU="${pkgs.bemenu}/bin/bemenu --ab '#24273a' --af '#cad3f5' --binding vim --cw 15 --fb '#24273a' --ff '#cad3f5' --fn 'IosevkaTerm Nerd Font 14' --hb '#24273a' --hf '#eed49f' --hp 10 --ignorecase --line-height 38 --nb '#24273a' --nf '#cad3f5' --prompt '  ' --tb '#24273a' --tf '#ed8796' --vim-esc-exits --wrap"

          mkdir -p "$CONFIG_DIR"

          if [ -n "$PRIMARY_RULE" ]; then
            PRIMARY_MONITOR_RULE="$PRIMARY_RULE"
          elif [ -f "$CONFIG_FILE" ]; then
            PRIMARY_MONITOR_RULE=$(${pkgs.gnugrep}/bin/grep "^monitorrule=" "$CONFIG_FILE" | ${pkgs.coreutils}/bin/head -n 1)
          else
            echo "Error: No PRIMARY_RULE set and no existing config found"
            exit 1
          fi

          if [ "$1" = "--no-override" ]; then
            if [ ! -f "$CONFIG_FILE" ]; then
              cat > "$CONFIG_FILE" << EOF
          $PRIMARY_MONITOR_RULE
          EOF
            fi
            exit 0
          fi

          PRIMARY_WIDTH=$(echo "$PRIMARY_MONITOR_RULE" | ${pkgs.coreutils}/bin/cut -d',' -f9)
          PRIMARY_HEIGHT=$(echo "$PRIMARY_MONITOR_RULE" | ${pkgs.coreutils}/bin/cut -d',' -f10)

          MONITORS_JSON=$(${pkgs.wlr-randr}/bin/wlr-randr --json)

          SECONDARY_COUNT=$(echo "$MONITORS_JSON" | ${pkgs.jq}/bin/jq 'length')

          if [ "$SECONDARY_COUNT" -eq 1 ]; then
            cat > "$CONFIG_FILE" << EOF
            $PRIMARY_MONITOR_RULE
          EOF
            $PRIMARY_MONITOR_RULE
            exit 0
          fi

          SECONDARY_LIST=$(echo "$MONITORS_JSON" | ${pkgs.jq}/bin/jq -r --arg primary "$PRIMARY" '.[] | select(.name != $primary) | .name')

          MONITOR_OPTIONS="Primary only
          $SECONDARY_LIST"

          SELECTED=$(echo "$MONITOR_OPTIONS" | $BEMENU -p "Select monitor:")

          if [ -z "$SELECTED" ] || [ "$SELECTED" = "Primary only" ]; then
            cat > "$CONFIG_FILE" << EOF
            $PRIMARY_MONITOR_RULE
          EOF
            exit 0
          fi

          SECONDARY="$SELECTED"

          SECONDARY_INDEX=$(echo "$MONITORS_JSON" | ${pkgs.jq}/bin/jq --arg name "$SECONDARY" 'to_entries[] | select(.value.name == $name) | .key')

          SECONDARY_MODE=$(echo "$MONITORS_JSON" | ${pkgs.jq}/bin/jq -r ".[$SECONDARY_INDEX].modes[] | select(.current == true)")
          SECONDARY_WIDTH=$(echo "$SECONDARY_MODE" | ${pkgs.jq}/bin/jq -r '.width')
          SECONDARY_HEIGHT=$(echo "$SECONDARY_MODE" | ${pkgs.jq}/bin/jq -r '.height')
          SECONDARY_REFRESH=$(echo "$SECONDARY_MODE" | ${pkgs.jq}/bin/jq -r '.refresh')

          POSITION=$(echo -e "Duplicate\nLeft\nRight\nAbove\nBelow" | $BEMENU -p "Position:")

          if [ -z "$POSITION" ]; then
            exit 1
          fi

          case $POSITION in
            "Duplicate")
              SEC_X=0
              SEC_Y=0
              ;;
            "Left")
              SEC_X=-$SECONDARY_WIDTH
              SEC_Y=0
              ;;
            "Right")
              SEC_X=$PRIMARY_WIDTH
              SEC_Y=0
              ;;
            "Above")
              SEC_X=0
              SEC_Y=-$SECONDARY_HEIGHT
              ;;
            "Below")
              SEC_X=0
              SEC_Y=$PRIMARY_HEIGHT
              ;;
            *)
              exit 1
              ;;
          esac

          cat > "$CONFIG_FILE" << EOF
          $PRIMARY_MONITOR_RULE
          monitorrule=$SECONDARY,0.55,1,tile,0,1.0,$SEC_X,$SEC_Y,$SECONDARY_WIDTH,$SECONDARY_HEIGHT,$SECONDARY_REFRESH
          EOF
        '';
      };
    })
  ];
}
