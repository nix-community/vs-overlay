{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, ffmpeg, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "d2vsource";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "dwbuiten";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-iq03BbrFqTB7n9gExLkp16TxgDZdUB4Ne8LUU69AOWc=";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ ffmpeg vapoursynth ];

  meta = with lib; {
    description = "D2V parser and decoder for VapourSynth";
    homepage = "https://github.com/dwbuiten/d2vsource";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
