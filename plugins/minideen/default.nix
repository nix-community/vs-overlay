{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, vapoursynth
}:

stdenv.mkDerivation rec {
  pname = "vapoursynth-minideen";
  version = "2";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-nwKK/dojmYEG/8d3shxyynNh0BbZbMk5ilvWtFBYzms=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [ vapoursynth ];

  NIX_CFLAGS_COMPILE = [
    "-O3"
  ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  meta = with lib; {
    description = "Spatial denoising plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-minideen";
    license = licenses.isc;
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
