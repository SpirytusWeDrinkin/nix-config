{ lib
, stdenv
, pkgs
}:
with pkgs;
stdenv.mkDerivation {
  name = "memory_controller";

  phases = [ "buildPhase" "installPhase" ];

  src = ./.;

  nativeBuildInputs = [
    autoreconfHook
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/memory_controller $out/bin/memory_controller;
  '';

  meta = with lib; {
    platforms = platforms.linux;
  };
}
