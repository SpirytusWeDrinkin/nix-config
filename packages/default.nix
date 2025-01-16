{ pkgs
, ...
}: {
  nswrapper = pkgs.callPackage ./nswrappers { };
  sddm-theme = pkgs.libsForQt5.callPackage ./sddm-theme { };
}
