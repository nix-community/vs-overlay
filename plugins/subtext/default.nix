{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, ffmpeg, libass, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "subtext";
  version = "3";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-Tux8WFbUn4Bt1EL9r+f+Y/av9w9Y23gc79m1JcZWj50=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ ffmpeg libass vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "Subtitle plugin for VapourSynth based on libass";
    homepage = "https://github.com/vapoursynth/subtext";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
