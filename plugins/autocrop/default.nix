{ lib, stdenv, fetchFromGitHub, vapoursynth }:

let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "vapoursynth-autocrop";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = version;
    sha256 = "15ph5w78d0p56n6x5ys24a1n0xs1bd1fbc783349px1l8606h1ac";
  };

  buildInputs = [ vapoursynth ];

  buildPhase = ''
    c++ -std=c++11 -shared -fPIC -O2 -I${vapoursynth}/include/vapoursynth \
        autocrop.cpp -o libautocrop${ext}
  '';

  installPhase = ''
    install -D libautocrop${ext} $out/lib/vapoursynth/libautocrop${ext}
  '';

  meta = with lib; {
    description = "Autocrop for VapourSynth";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vapoursynth-autocrop";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
