{ username, pkgs, rootPath, ... }:

{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      playerctl
    ];

    file.".face.icon".source = "${rootPath}/assets/Avatars/${username}.png";
  };
}
