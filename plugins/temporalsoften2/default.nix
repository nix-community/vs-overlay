{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, vapoursynth
}:

stdenv.mkDerivation rec {
  pname = "vapoursynth-temporalsoften2";
  version = "unstable-2019-03-25";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "a133670676a311dde31b0eb1a771bbd94ffb1235";
    sha256 = "sha256-RxFSDmwzBuO7EfxryV2UZRAjGCW3JcGtcCX+mDnAYb8=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  meta = with lib; {
    description = "TemporalSoften filter plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-temporalsoften2";
    license = licenses.lgpl2;
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
