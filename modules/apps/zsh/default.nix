{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.misc.zsh;
in
{
  options.misc.zsh = { enable = mkEnableOption "zsh"; };
  config = mkIf cfg.enable {
    /* imports = [
      ./starship.nix
    ]; */

    programs.zsh = {
      enable = true;
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
            sha256 = "1m8yawj7skbjw0c5ym59r1y88klhjl6abvbwzy6b1xyx3vfb7qh7";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
            hash = "sha256-4rW2N+ankAH4sA6Sa5mr9IKsdAg7WTgrmyqJ2V1vygQ=";
          };
        }
      ];
      shellAliases = {
        v = "nvim";
        ls = "lsd";
        c = "clear";
        hrc = "nvim ~/.dotfiles/flake.nix";
        config = "nvim ~/.dotfiles/configuration.nix";
        rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles/#system";
        home = "home-manager switch --flake ~/.dotfiles/#user";
        shell = "nix-shell --run \"zsh\"";
        ":wq" = "exit";
      };
      initExtra = ''
        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      '';
    };
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        palette = "catppuccin_macchiato";
        scan_timeout = 10;
        character = {
          success_symbol = " [[♥ ](green)  ](maroon)";
          error_symbol = "[ ](red)";
          vimcmd_symbol = "[ ](green)";
        };
        directory = {
          style = "bold lavender";
        };
        palettes.catppuccin_macchiato = {
          rosewater = "#f4dbd6";
          flamingo = "#f0c6c6";
          pink = "#f5bde6";
          mauve = "#c6a0f6";
          red = "#ed8796";
          maroon = "#ee99a0";
          peach = "#f5a97f";
          yellow = "#eed49f";
          green = "#a6da95";
          teal = "#8bd5ca";
          sky = "#91d7e3";
          sapphire = "#7dc4e4";
          blue = "#8aadf4";
          lavender = "#b7bdf8";
          text = "#cad3f5";
          subtext1 = "#b8c0e0";
          subtext0 = "#a5adcb";
          overlay2 = "#939ab7";
          overlay1 = "#8087a2";
          overlay0 = "#6e738d";
          surface2 = "#5b6078";
          surface1 = "#494d64";
          surface0 = "#363a4f";
          base = "#24273a";
          mantle = "#1e2030";
          crust = "#181926";
        };
      };
    };
  };
}
