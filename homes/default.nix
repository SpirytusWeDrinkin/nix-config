{
  inputs,
  outputs,
  ...
}:
let
  inherit (inputs) home-manager;
  rootPath = ../.;
in
{
  home-manager.useGlobalPkgs = true;
  "abel.chartier@pie" = home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {
      username = "abel.chartier";
      rootPath = rootPath;
      stateVersion = "25.05";
      inherit inputs outputs;
    };

    modules = [
      ./pie
    ];
  };

  "abel.chartier@hyprpie" = home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {
      username = "abel.chartier";
      rootPath = rootPath;
      stateVersion = "25.05";
      inherit inputs outputs;
    };

    modules = [
      ./hyprpie
    ];
  };

  "abelc@rog-laptop" = home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {
      username = "abelc";
      rootPath = rootPath;
      stateVersion = "25.05";
      inherit inputs outputs;
    };

    modules = [
      ./abelc-laptop
    ];
  };
}
