{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, libbluray, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-ReadMpls";
  version = "4";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "0v1hs0wgpv9raacsslmwhsw81c49c52mhc6py2ydxb0b359rqg2n";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ libbluray vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "ReadMpls filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-ReadMpls";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
