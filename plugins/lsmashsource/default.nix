{ stdenv, fetchFromGitHub, pkg-config, which, vapoursynth, ffmpeg, l-smash }:

stdenv.mkDerivation {
  pname = "lsmashsource";
  version = "unstable-2017-08-12"; # last (only) release is from 2013 and there has still been development

  src = fetchFromGitHub {
    owner = "VFR-maniac";
    repo = "L-SMASH-Works";
    rev = "3edd194b1d82975cee67c0278556615c7d9ebd36";
    sha256 = "0q5xww6rkfi9vqwafpi9cvvywn1hx5fhkhqz0ck7x235cc3lb2qz";
  };

  preConfigure = ''
    patchShebangs .
    cd VapourSynth
  '';

  nativeBuildInputs = [ pkg-config which ];
  buildInputs = [ vapoursynth ffmpeg l-smash ];
}
