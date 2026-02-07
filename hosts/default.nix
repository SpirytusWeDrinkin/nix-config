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
        inputs.mango.nixosModules.mango
        ./rog-laptop
        ./configuration.nix
      ];
    };
  lenovo-laptop =
    let
      username = "abel";
      stateVersion = "25.05";
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
        stateVersion = stateVersion;
        username = username;
      };
      modules = [
        inputs.mango.nixosModules.mango
        ./lenovo-laptop
        ./configuration.nix
      ];
    };
  lenny-laptop =
    let
      username = "lenny";
      stateVersion = "25.05";
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
        stateVersion = stateVersion;
        username = username;
      };
      modules = [
        inputs.mango.nixosModules.mango
        ./lenny-laptop
        ./configuration.nix
      ];
    };

}
