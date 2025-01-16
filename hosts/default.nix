{ inputs, pkgs, modules, system, lib, username, pkgs-local, ... }:
let
  inherit (inputs) home-manager;
  specialArgs = {
    inherit
      inputs
      # pkgs
      pkgs-local
      username
      system
      ;
    stateVersion = "25.05";
    rootPath = ../.;
  };
in
{
  rog-laptop = lib.nixosSystem {
    inherit system specialArgs;
    modules = [
      ./rog-laptop
      ./configuration.nix
      inputs.stylix.nixosModules.stylix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${username} = {
          imports = [
            ./home.nix
            ./rog-laptop/home.nix
          ] ++ modules.homeManager;
        };
      }
    ] ++ modules.nixos;
  };
}
