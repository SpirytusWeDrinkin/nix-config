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

  buildInputs = [
    autoconf-archive
  ];

  meta = with lib; {
    platforms = platforms.linux;
  };
}
