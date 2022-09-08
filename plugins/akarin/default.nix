{ lib, stdenv, fetchFromGitHub, meson, pkg-config, ninja, vapoursynth, llvmPackages_13, libxml2 }:

stdenv.mkDerivation rec {
  pname = "akarin";
  version = "0.94";

  src = fetchFromGitHub {
    owner = "AkarinVS";
    repo = "vapoursynth-plugin";
    rev = "v${version}";
    sha256 = "sha256-oExdp3L4Jf13NUxV/sfX7Ff4gWzy1SMOKBxKDyFnAss=";
  };

  nativeBuildInputs = [ meson pkg-config ninja ];
  buildInputs = [ vapoursynth llvmPackages_13.llvm libxml2 ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "AkarinVS's vapoursynth-plugin";
    homepage = "https://github.com/AkarinVS/vapoursynth-plugin";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
