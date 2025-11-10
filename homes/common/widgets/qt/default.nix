{ pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.package = pkgs.catppuccin-qt5ct;
  };
}
