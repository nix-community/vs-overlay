{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vs-removegrain";
  version = "unstable-2021-09-27";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "ea3d1566b7d82e1efb2f30612d6951dc61ebba65";
    sha256 = "sha256-yg6VSZzkxFLzW/bTNMx0EollzzJtMKxRuwwXBH326aI=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "VapourSynth port of RemoveGrain and Repair plugins from Avisynth";
    homepage = "https://github.com/vapoursynth/vs-removegrain";
    license = with licenses; [ mit unfree wtfpl ]; # only some files have license header
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
