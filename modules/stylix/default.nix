{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.abelc.stylix;
in
{
  options.abelc.stylix = { enable = mkEnableOption "stylix"; };
  config = mkIf cfg.enable {
    stylix.enable = true;

    stylix = {
      autoEnable = false;

      image = ./cisco.png;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Moderne-Ice";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.iosevka-term;
          name = "IosevkaTerm Nerd Font";
        };
        sansSerif = {
          package = pkgs.montserrat;
          name = "Montserrat";
        };
        serif = {
          package = pkgs.montserrat;
          name = "Montserrat";
        };
      };

      fonts.sizes = {
        applications = 15;
        terminal = 15;
        desktop = 15;
        popups = 15;
      };

      opacity = {
        terminal = 0.8;
      };
    };

    home-manager.sharedModules = [{
      stylix.targets.alacritty.enable = true;
      # stylix.targets.waybar.enable = true;
      # stylix.targets.hyprland.enable = true;
      stylix.targets.bemenu.enable = true;
      stylix.targets.firefox.enable = true;
    }];
  };
}
