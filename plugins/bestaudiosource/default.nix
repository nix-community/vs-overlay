{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, ffmpeg, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "bestaudiosource";
  version = "unstable-2021-09-28";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "87d6cba4a119f347e146de8f9751646b6f21284c";
    sha256 = "sha256-ylNPv/QOBcJk6QTuXL/W6kJGJ+7Yg7WEFS5HEp7AIYY=";
  };

  patches = [
    ./0001-Fix-audio-source-iteration-with-Wsign-compare.patch
  ];

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ ffmpeg vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "Audio source and FFmpeg wrapper plugin for VapourSynth";
    homepage = "https://github.com/vapoursynth/bestaudiosource";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
