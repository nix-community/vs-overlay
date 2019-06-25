{ stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-addgrain";
  version = "r7";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-AddGrain";
    rev = version;
    sha256 = "1lww67qqss7ixhbdhziw3s79fp837xcp66ddn4ryq3srp7rgimdq";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  installPhase =
    let
      ext = stdenv.targetPlatform.extensions.sharedLibrary;
    in ''
      install -D libaddgrain${ext} $out/lib/vapoursynth/libaddgrain${ext}
    '';

  meta = with stdenv.lib; {
    description = "AddGrain filter for VapourSynth";
    homepage = https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain;
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
