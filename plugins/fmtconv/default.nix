{ stdenv, fetchFromGitHub, autoreconfHook, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "fmtconv";
  version = "r20";

  src = fetchFromGitHub {
    owner = "EleonoreMizo";
    repo = pname;
    rev = version;
    sha256 = "0yaxyiljllzrhx5p4pmnj8vp9ywi7mcyn861y1cyawdgkraylcyy";
  };

  preAutoreconf = "cd build/unix";

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ vapoursynth ];

  meta = with stdenv.lib; {
    description = "Format conversion tools for VapourSynth";
    homepage = https://github.com/EleonoreMizo/fmtconv;
    license = licenses.wtfpl;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
