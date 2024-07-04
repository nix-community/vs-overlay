{ lib, stdenv, fetchFromGitHub, autoreconfHook, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "fmtconv";
  version = "29";

  src = fetchFromGitHub {
    owner = "EleonoreMizo";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-V2iY8mBIFtkLkiHXlN/KrlBmzCEpGStHYaOcJSTU9LE=";
  };

  preAutoreconf = "cd build/unix";

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "Format conversion tools for VapourSynth";
    homepage = "https://github.com/EleonoreMizo/fmtconv";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
