{
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  pkg-config,
  ffmpeg,
  vapoursynth,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "d2vsource";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "dwbuiten";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-iq03BbrFqTB7n9gExLkp16TxgDZdUB4Ne8LUU69AOWc=";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];
  buildInputs = [
    ffmpeg
    vapoursynth
  ];

  meta = with lib; {
    description = "D2V parser and decoder for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-cnr2";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
})
