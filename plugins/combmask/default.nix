{ lib, stdenv, fetchFromGitHub, pkg-config, which, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "CombMask";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "chikuzen";
    repo = pname;
    rev = version;
    sha256 = "04axqp44w7vqrc6lr88j7j1xvj18sbx6fyyqjkqlcvqnn0kg4ksn";
  };

  postPatch = ''
    # headers are provided by nixpkgs’ vapoursynth
    rm vapoursynth/src/VapourSynth.h
  '';

  preConfigure = ''
    cd vapoursynth/src
  '';

  configurePhase = ''
    runHook preConfigure

    bash configure \
        --extra-cflags="$(pkg-config --cflags vapoursynth)" \
        --cc="$CC" \
        --install="$out/lib/vapoursynth"

    runHook postConfigure
  '';

  nativeBuildInputs = [ pkg-config which ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "A comb mask create filter for VapourSynth";
    homepage = "https://github.com/chikuzen/CombMask";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
