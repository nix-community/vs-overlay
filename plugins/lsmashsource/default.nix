{ lib, stdenv, fetchFromGitHub, meson, pkg-config, ninja, vapoursynth, ffmpeg, l-smash }:

stdenv.mkDerivation (finalAttrs: {
  pname = "lsmashsource";
  version = "1141.0.0.0";

  src = fetchFromGitHub {
    owner = "HomeOfAviSynthPlusEvolution";
    repo = "L-SMASH-Works";
    rev = finalAttrs.version;
    sha256 = "sha256-fKjskDJmTez273qSV6Wf3o1oINGMPLuMcAWkR1fX7DQ=";
  };

  sourceRoot = "${finalAttrs.src.name}/VapourSynth";

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ffmpeg l-smash ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  meta = with lib; {
    description = "L-SMASH source plugin for VapourSynth";
    homepage = "https://github.com/HomeOfAviSynthPlusEvolution/L-SMASH-Works";
    license = with licenses; [ isc lgpl21Plus ];
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
})
