{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-beziercurve";
  version = "3";

  src = fetchFromGitHub {
    owner = "kewenyu";
    repo = "VapourSynth-BezierCurve";
    rev = "r${version}";
    sha256 = "1513ndj7sxwihyxx6x9ciyd8jhw9vs6lhzw7fpl7cz7fdj49wwi6";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "A bézier curve plugin for VapourSynth";
    homepage = "https://github.com/kewenyu/VapourSynth-BezierCurve";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
