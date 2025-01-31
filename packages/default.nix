{ pkgs
, ...
}: {
  nswrapper = pkgs.callPackage ./nswrappers { };
  sddm-theme = pkgs.libsForQt5.callPackage ./sddm-theme { };
  memory_controller = pkgs.callPackage ./memory_controller { };
}
