{ ... }:

{
  imports = [
    ./starship.nix
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      v = "nvim";
      ls = "lsd";
      c = "clear";
      hrc = "nvim ~/.dotfiles/user/home.nix";
      config = "nvim ~/.dotfiles/configuration.nix";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
      home = "home-manager switch --flake ~/.dotfiles/";
    };
  };
}
