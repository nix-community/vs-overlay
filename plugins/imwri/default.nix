{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, imagemagick, libheif, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vs-imwri";
  version = "1";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-3nNX7OxAwHPJ6JwaTZJTH13eWktPI/XBmEC/OETCun4=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ imagemagick libheif vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_variable(pkgconfig: 'libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "Image reader and writer for VapourSynth using the ImageMagick library";
    homepage = "https://github.com/vapoursynth/vs-imwri";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
