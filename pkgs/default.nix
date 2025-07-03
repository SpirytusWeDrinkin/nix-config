pkgs: {
  sddm-theme = pkgs.libsForQt5.callPackage ./sddm-theme { };
  control_modules = pkgs.callPackage ./control_modules { };
}
