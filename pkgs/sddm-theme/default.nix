{
  lib,
  qtbase,
  qtsvg,
  qtgraphicaleffects,
  qtquickcontrols2,
  wrapQtAppsHook,
  stdenvNoCC,
  wallpaper ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "sddm-theme-corners";
  version = "1.0";
  dontBuild = true;
  src = ./.;

  nativeBuildInputs = [
    wrapQtAppsHook
  ];

  propagatedUserEnvPkgs = [
    qtbase
    qtsvg
    qtgraphicaleffects
    qtquickcontrols2
  ];

  installPhase =
    let
      basePath = "$out/share/sddm/themes/sddm-theme-corners/";
    in
    ''
      mkdir -p ${basePath}
      cp -R ./corners/* ${basePath}
    ''
    + lib.optionalString (wallpaper != null) ''
      cd ${basePath}
      rm backgrounds/wallpaper.png
      cp -r ${wallpaper} backgrounds/wallpaper.png
    '';
}
