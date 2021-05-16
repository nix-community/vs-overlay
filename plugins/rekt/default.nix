{ lib, buildPythonPackage, fetchFromGitLab, vapoursynthPlugins, vapoursynth }:

buildPythonPackage rec {
  pname = "rekt";
  version = "r39";

  src = fetchFromGitLab {
    owner = "Ututu";
    repo = pname;
    rev = "153863e07779219c48cf1223bfdba86c47bc43be";
    sha256 = "1h83dqwn71pfqxx8hppbqc7i9mh0a2pbpydsm8jvf538z9nr2sl9";
  };

  # This does not depend on vapoursynth (since this is used from within
  # vapoursynth).
  postPatch = ''
    substituteInPlace setup.py \
        --replace "install_requires=['vapoursynth', " "install_requires=["
  '';

  propagatedBuildInputs = with vapoursynthPlugins; [
    vsutil
  ];

  checkInputs = [ vapoursynth ];
  checkPhase = ''
    runHook preCheck
    # This overrides the default setuptools checkPhase that detects tests (that
    # don’t work) even though this package doesn’t have tests.
    runHook postCheck
  '';
  pythonImportsCheck = [ "rekt" ];

  meta = with lib; {
    description = "VapourSynth wrapper for Cropping and Stacking clips";
    homepage = "https://gitlab.com/Ututu/rekt";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
