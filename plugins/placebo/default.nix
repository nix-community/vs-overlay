{ lib, stdenv, fetchFromGitHub, fetchpatch, meson, ninja, pkg-config, libplacebo, vapoursynth, vulkan-headers, vulkan-loader }:

stdenv.mkDerivation rec {
  pname = "vs-placebo";
  version = "1.4.2";

  src = fetchFromGitHub {
    owner = "Lypheo";
    repo = pname;
    rev = version;
    sha256 = "sha256-nerS1z/Ch/UqcmcY2gNL1Xl3hs1/etEAODj8pzrSuEE=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ libplacebo vapoursynth vulkan-headers vulkan-loader ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "A libplacebo-based debanding, scaling and color mapping plugin for VapourSynth";
    homepage = "https://github.com/Lypheo/vs-placebo";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
