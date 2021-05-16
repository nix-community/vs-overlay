{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-fillborders";
  version = "2";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "0c3y24796km382i6bn2ixqc6yfb87ipclvgp20b7h9rhg8sfhf9i";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postInstall = ''
    # it installs the library in the wrong directory
    mkdir $out/lib/vapoursynth
    mv $out/lib/libfillborders.* $out/lib/vapoursynth/
  '';

  meta = with lib; {
    description = "VapourSynth plugin to fill the borders of a clip";
    homepage = "https://github.com/dubhater/vapoursynth-fillborders";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
