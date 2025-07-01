{
  inputs,
  outputs,
  ...
}:
{
  rog-laptop =
    let
      username = "abelc";
      stateVersion = "25.05";
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
        stateVersion = stateVersion;
        username = username;
      };
      modules = [
        inputs.maomaowm.nixosModules.maomaowm
        ./rog-laptop
        ./configuration.nix
      ];
    };
}
