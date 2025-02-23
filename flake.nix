{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    futils = {
      url = "github:numtide/flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    nvim = {
      url = "github:Orysse/nixvim";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      futils,
      home-manager,
      stylix,
      catppuccin,
      nvim,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (futils.lib) eachDefaultSystemMap;

      system = "x86_64-linux";
      username = "abelc";

      mkDefaultArgs =
        system:
        let
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            config.allowUnsupportedSystem = true;
            inherit system;
          };
          pkgs-local = self.packages.${system};
        in
        {
          inherit (self) inputs outputs;
          inherit
            pkgs
            pkgs-local
            system
            username
            lib
            ;
        };

      defaultArgs = mkDefaultArgs system;
    in
    rec {
      packages = eachDefaultSystemMap (
        system:
        let
          defaultArgs = mkDefaultArgs system;
        in
        { home-manager = home-manager.packages.${system}.default; } // (import ./packages defaultArgs)
      );

      nixosModules = import ./modules/nixos;

      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations =
        let
          modules = {
            # homeManager = lib.attrsets.ates homeManagerModules;
            nixos = lib.attrsets.attrValues nixosModules;
          };
        in
        (import ./hosts (defaultArgs // { inherit modules; }));

      homeConfigurations = (import ./homes (defaultArgs));

      formatter = eachDefaultSystemMap (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
