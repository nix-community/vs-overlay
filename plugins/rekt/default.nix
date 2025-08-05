{
  lib,
  buildPythonPackage,
  fetchFromGitLab,
  vapoursynthPlugins,
  vapoursynth,
}:

buildPythonPackage rec {
  pname = "rekt";
  version = "0-unstable-2022-03-02";

  src = fetchFromGitLab {
    owner = "Ututu";
    repo = pname;
    rev = "ca1b679317bb096a96bf676111d855ca4c2c6f63";
    sha256 = "sha256-zmtxdFMoZfYNgYjF5lb3824Be3c9K23RC4Y52F633Wc=";
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
