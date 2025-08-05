{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  imagemagick,
  libheif,
  libtiff,
  vapoursynth,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "vs-imwri";
  version = "R2-unstable-2024-09-18";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = finalAttrs.pname;
    rev = "da17f01b9581a78ee5b54edf5b6f47d5f8e3d2f5";
    hash = "sha256-0J/2+pvxROFIERRhr3JeiI57F2g/aOZ2+7eX7Jw+l5g=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];
  buildInputs = [
    imagemagick
    libheif
    libtiff
    vapoursynth
  ];

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
})
