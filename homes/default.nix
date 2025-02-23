{
  inputs,
  outputs,
  pkgs,
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
      inherit inputs outputs;
    };

    modules = [
      catppuccin.homeManagerModules.catppuccin
      # outputs.homeManagerModules.git
      ./pie.nix
    ];
  };
}
