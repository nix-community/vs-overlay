{ lib, stdenv, fetchFromGitHub, fetchpatch, meson, ninja, pkg-config, libplacebo, vapoursynth, vulkan-headers, vulkan-loader }:

stdenv.mkDerivation rec {
  pname = "vs-placebo";
  version = "1.4.4";

  src = fetchFromGitHub {
    owner = "Lypheo";
    repo = pname;
    rev = version;
    sha256 = "sha256-1DTdllP+Y4s+t2PMnpcgeLjOxOyyV/yhFSxPP9/Gy9M=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ libplacebo vapoursynth vulkan-headers vulkan-loader ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_variable(pkgconfig: 'libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "A libplacebo-based debanding, scaling and color mapping plugin for VapourSynth";
    homepage = "https://github.com/Lypheo/vs-placebo";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
