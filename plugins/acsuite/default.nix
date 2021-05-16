{ lib, buildPythonPackage, fetchFromGitHub, ffmpeg, vapoursynth }:

buildPythonPackage rec {
  pname = "acsuite";
  version = "6.0.0";

  src = fetchFromGitHub {
    owner = "OrangeChannel";
    repo = pname;
    rev = "v${version}";
    sha256 = "0m7xfg2jifq7hz7vaxvb15hgq4abna7b2zgjahjgscxjk2r4lg46";
  };

  postPatch = ''
    # Sets the default ffmpeg executable to nixpkgs’ ffmpeg. This still allows
    # overriding the executable by passing ffmpeg_path.
    substituteInPlace acsuite/__init__.py \
        --replace 'raise FileNotFoundError("concat: ffmpeg executable not found in PATH")' 'ffmpeg_path = "${ffmpeg}/bin/ffmpeg"'

    # This does not depend on vapoursynth (since this is used from within
    # vapoursynth).
    substituteInPlace requirements.txt \
        --replace "VapourSynth" ""
  '';

  checkInputs = [
    ffmpeg # the test depdends on ffmpeg from PATH
    vapoursynth
  ];
  checkPhase = ''
    runHook preCheck

    pushd tests
    python3 test_acsuite.py
    popd

    runHook postCheck
  '';
  pythonImportsCheck = [ "acsuite" ];

  meta = with lib; {
    description = "An audiocutter.py replacement for VapourSynth using FFmpeg";
    homepage = "https://github.com/OrangeChannel/acsuite";
    license = licenses.unlicense;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
