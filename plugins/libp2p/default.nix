{ lib, stdenv, fetchFromGitHub, vapoursynth, meson, ninja, pkg-config }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-libp2p";
  version = "unstable-2022-09-07";

  src = fetchFromGitHub {
    owner = "DJATOM";
    repo = "LibP2P-Vapoursynth";

    rev = "770cc3157b41b7b336b2f2e85be01830dcb80d2c";
    sha256 = "sha256-Xokf5m7UIrW1C03C4X/6D37NbDwVGxQjPk2DRz4MQic=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "VapourSynth plugin for packing/unpacking of RGB clips";
    homepage = "https://github.com/DJATOM/LibP2P-Vapoursynth";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
