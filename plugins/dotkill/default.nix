{ lib, stdenv, fetchFromGitHub, vapoursynth }:
stdenv.mkDerivation rec {
  pname = "DotKill";
  version = "2";

  src = fetchFromGitHub {
    owner = "myrsloik";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-TqOKhorFdRmVPTBEM0QU/Zol80oDpIgZFA5tDIgQByc=";
  };

  buildPhase = ''
  $CXX -shared dotkill1.cpp -I${vapoursynth}/include/vapoursynth -o libdotkill.so
  '';

  installPhase = ''
  mkdir -p $out/lib/vapoursynth
  cp libdotkill.so $out/lib/vapoursynth/libdotkill.so
  '';

  meta = with lib; {
    description = "Spatio-temporal dotcrawl and rainbow remover for VapourSynth";
    homepage = "https://github.com/myrsloik/DotKill";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
