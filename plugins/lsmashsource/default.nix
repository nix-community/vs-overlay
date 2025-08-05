{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  meson,
  ninja,
  nasm,
  which,
  vapoursynth,
  ffmpeg,
  l-smash,
  xxHash,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "lsmashsource";
  version = "b43f75fab4a6f7330e24855c9f7c9c971cd626d9";

  src = fetchFromGitHub {
    owner = "HomeOfAviSynthPlusEvolution";
    repo = "L-SMASH-Works";
    rev = finalAttrs.version;
    hash = "sha256-64e1tDNFVyJnH0q41K9PT5YOxginhTYaj9NtdPu/g6A=";
  };

  preConfigure = ''
    patchShebangs .
    cd VapourSynth
  '';

  postPatch = ''
    substituteInPlace VapourSynth/meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    which
  ];
  buildInputs = [
    l-smash
    vapoursynth
    xxHash
    (ffmpeg.override {
      source = fetchFromGitHub {
        owner = "HomeOfAviSynthPlusEvolution";
        repo = "FFmpeg";
        rev = "custom-patches-for-lsmashsource";
        hash = "sha256-eMnn8G63BUU/dUWW8JIMkr67DI7atxmNpkYGwnnL37E=";
      };
      yasm = nasm;
    })
  ];

  meta = with lib; {
    description = "L-SMASH source plugin for VapourSynth";
    homepage = "https://github.com/VFR-maniac/L-SMASH-Works";
    license = with licenses; [
      isc
      lgpl21Plus
    ];
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
})
