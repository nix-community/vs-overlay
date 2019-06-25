{ stdenv, fetchFromGitHub, wafHook, python3, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "flash3kyuu_deband";
  version = "2.0.0-1";

  src = fetchFromGitHub {
    owner = "SAPikachu";
    repo = pname;
    rev = version;
    sha256 = "0qfm85z2r9kr56i406bfz04wb92amkrsgbhdrp0dpfp6xvhv72nj";
  };

  wafConfigureFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  nativeBuildInputs = [ wafHook python3 ];
  buildInputs = [ vapoursynth ];

  meta = with stdenv.lib; {
    description = "A deband library and filter for AviSynth/VapourSynth";
    homepage = https://github.com/SAPikachu/flash3kyuu_deband;
    license = licenses.gpl3;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
