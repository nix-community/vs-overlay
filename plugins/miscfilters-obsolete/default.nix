{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, tesseract, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vs-miscfilters-obsolete";
  version = "unstable-2022-01-24";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "07e0589a381f7deb3bf533bb459a94482bccc5c7";
    sha256 = "sha256-WEhpBTNEamNfrNXZxtpTGsOclPMRu+yBzNJmDnU0wzQ=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "A collection of VapourSynth filters that mostly are useful for Avisynth compatibility";
    homepage = "https://github.com/vapoursynth/vs-miscfilters-obsolete";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
