{ inputs
, pkgs
, modules
, ...
}:
let
  inherit (inputs) home-manager;
in
{
  home-manager.useGlobalPkgs = true;
  "pie" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      username = "abel.chartier";
    };

    modules = [
      ./pie.nix
    ] ++ modules;
  };
}
