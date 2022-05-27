{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth, fftwSinglePrec }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-bm3d";
  version = "9";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-BM3D";
    rev = "r${version}";
    sha256 = "sha256-i7Kk7uFt2Wo/EWpVkGyuYgGZxBuQgOT3JM+WCFPHVrc=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth fftwSinglePrec ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "BM3D denoising filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D";
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
