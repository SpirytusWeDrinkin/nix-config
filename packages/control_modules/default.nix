{ lib
, stdenv
, pkgs
}:
with pkgs;
stdenv.mkDerivation {
  name = "memory_controller";

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
