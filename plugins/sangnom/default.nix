{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-sangnom";
  version = "42";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "r${version}";
    sha256 = "0g9gr4lj5krwlkxb6fc1b408zj5gnl8v36hr66r27h9ndg12flfs";
  };

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "VapourSynth Single Field Deinterlacer";
    homepage = "https://github.com/dubhater/vapoursynth-sangnom";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
