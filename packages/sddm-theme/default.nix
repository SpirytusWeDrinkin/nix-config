{ lib
, qtbase
, qtsvg
, qtgraphicaleffects
, qtquickcontrols2
, wrapQtAppsHook
, stdenvNoCC
, fetchFromGitHub
, wallpaper ? null
}:
stdenvNoCC.mkDerivation
rec {
  pname = "sddm-theme-corners";
  version = "1.0";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "Orysse";
    repo = "sddm-theme-corners";
    rev = "98eb3e3aa8b86506ea2cd831a2240f3d2a383594";
    hash = "sha256-PXKpnAAv14tH/ezet8UlLL+N9iiroL+Rj+7rqUomTK4=";
  };

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
