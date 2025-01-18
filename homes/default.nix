{ inputs
, pkgs
, modules
, pkgs-local
, ...
}:
let
  inherit (inputs) home-manager;
  specialArgs = {
    inherit
      inputs
      pkgs-local
      ;
    stateVersion = "25.05";
    rootPath = ../.;
  };
in
{
  home-manager.useGlobalPkgs = true;
  "pie" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      username = "abel.chartier";
    }
    ++ specialArgs;

    modules = [
      ./pie.nix
    ] ++ modules;
  };
}
