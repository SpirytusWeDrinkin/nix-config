{
  inputs,
  pkgs,
  modules,
  pkgs-local,
  ...
}:
let
  inherit (inputs) home-manager catppuccin;
  rootPath = ../.;
in
{
  home-manager.useGlobalPkgs = true;
  "pie" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      username = "abel.chartier";
      rootPath = rootPath;
      stateVersion = "25.05";
      inherit pkgs-local;
      inherit inputs;
    };

    modules = [
      catppuccin.homeManagerModules.catppuccin
      ./pie.nix
    ] ++ modules;
  };
}
