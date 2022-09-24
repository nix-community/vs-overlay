{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, cmake
, pkg-config
, vapoursynth
}:

stdenv.mkDerivation rec {
  pname = "vapoursynth-decross";
  version = "1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-BrtxBS1/q1rldVh8P9eHCeBoo/EueZ3TOrhaotV8l6g=";
  };

  nativeBuildInputs = [
    meson
    ninja
    cmake
    pkg-config
  ];

  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  meta = with lib; {
    description = "A rainbow reduction filter plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-decross";
    license = licenses.gpl2;
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
