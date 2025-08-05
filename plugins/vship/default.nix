{
  lib,
  stdenv,
  fetchFromGitHub,
  hostPlatform,
  rocmPackages,
  vapoursynth,
}:

stdenv.mkDerivation rec {
  pname = "vship";
  version = "2.2";

  src = fetchFromGitHub {
    owner = "Line-fr";
    repo = "Vship";
    rev = "v${version}";
    hash = "sha256-uA2pxv46IVD6/ynoxlS6aB3agyq0AgaQU3I2GqfssNo=";
  };

  nativeBuildInputs = [
    rocmPackages.clr
  ];

  buildInputs =
    (with rocmPackages; [
      clr
      rocm-comgr
      rocm-runtime
    ])
    ++ [
      vapoursynth
    ];

  postPatch = ''
    rm -rf include
  '';

  buildPhase = ''
    echo $PATH
    hipcc src/main.cpp \
      -I "${vapoursynth}/include/vapoursynth"
      --offload-arch=gfx1100,gfx1101,gfx1102,gfx1030,gfx1031,gfx1032,gfx906,gfx801,gfx802,gfx803 \
      -Wno-unused-result -Wno-ignored-attributes -shared -fPIC \
      -o "vship${hostPlatform.extensions.sharedLibrary}" -v
  '';

  installPhase = ''
    install -D -t "$out/lib/vapoursynth" vship${hostPlatform.extensions.sharedLibrary}
  '';

  meta = {
    description = "A high-performance VapourSynth plugin for GPU-accelerated visual fidelity metrics, focusing on SSIMULACRA2 & Butteraugli";
    homepage = "https://github.com/Line-fr/Vship";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ snaki ];
    mainProgram = "vship";
    platforms = lib.platforms.all;
  };
}
