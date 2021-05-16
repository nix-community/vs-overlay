{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, vapoursynth, xvidcore }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-scxvid";
  version = "1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "13afl3bsg4fx3w5myrbsd62sf76s9qhsggfn2fjai9vfq61lnb0f";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ];
  buildInputs = [ vapoursynth xvidcore ];

  meta = with lib; {
    description = "Scene change detection plugin for VapourSynth using xvid";
    homepage = "https://github.com/dubhater/vapoursynth-scxvid";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
