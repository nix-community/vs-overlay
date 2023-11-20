{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, python3, vapoursynth, tbb }:

stdenv.mkDerivation (finalAttrs: {
  pname = "neo_f3kdb";
  version = "r9";

  src = fetchFromGitHub {
    owner = "HomeOfAviSynthPlusEvolution";
    repo = finalAttrs.pname;
    rev = finalAttrs.version;
    sha256 = "sha256-MIvKjsemDeyv9qonuJbns0Dau8BjFQ1REppccs7s9JU=";
  };

  patches = [
    ./no-git.patch
  ];

  nativeBuildInputs = [ cmake pkg-config python3 ];
  buildInputs = [ vapoursynth tbb ];

  cmakeFlags = [
    "-DVERSION=${finalAttrs.version}"
  ];

  installPhase = ''
    runHook preInstall

    install -D --target-directory="$out/lib/vapoursynth" *.so

    runHook postInstall
  '';

  meta = with lib; {
    description = "A deband library and filter for AviSynth/VapourSynth";
    homepage = "https://github.com/HomeOfAviSynthPlusEvolution/neo_f3kdb";
    license = licenses.gpl3;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
})
