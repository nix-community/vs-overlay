{ stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-sangnom";
  version = "r41";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = version;
    sha256 = "1q6iz20sjipfmvn16bjvic25n77crpak2nzcvhrp483n5ccqricw";
  };

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  meta = with stdenv.lib; {
    description = "VapourSynth Single Field Deinterlacer";
    homepage = https://github.com/dubhater/vapoursynth-sangnom;
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
