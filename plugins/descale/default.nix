{ stdenv, fetchFromGitHub, vapoursynth, python }:

let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "vapoursynth-descale";
  version = "r2";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = version;
    sha256 = "1vsg6iwbm277hsiawfi6n5h9b7n2n6grl5b287rkb5x2qa88zs0k";
  };

  buildInputs = [ vapoursynth ];

  buildPhase = ''
    c++ -std=c++11 -shared -fPIC -O2 -I${vapoursynth.dev}/include/vapoursynth \
        descale.cpp -o libdescale${ext}
  '';

  outputs = [ "out" ];

  installPhase = ''
    install -D libdescale${ext} $out/lib/vapoursynth/libdescale${ext}
    install -D descale.py $out/lib/${python.libPrefix}/site-packages/descale.py
  '';

  meta = with stdenv.lib; {
    description = "VapourSynth plugin to undo upscaling";
    homepage = https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale;
    license = licenses.wtfpl;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
