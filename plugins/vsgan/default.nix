{ lib
, buildPythonPackage
, fetchFromGitHub
, vapoursynth
, numpy
, poetry
, pytorch
}:

buildPythonPackage rec {
  pname = "vsgan";
  version = "1.6.4";

  src = fetchFromGitHub {
    owner = "rlaphoenix";
    repo = "VSGAN";
    rev = "v${version}";
    sha256 = "sha256-bMgCah3kkyxNU5tb/eLt0tuG4xnD4sbtAzUK0a4uOKE=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    numpy
    poetry
    pytorch
  ];

  checkInputs = [
    vapoursynth
  ];

  pythonImportsCheck = [ "vsgan" ];

  meta = with lib; {
    description = "ESRGAN for VapourSynth";
    homepage = "https://vsgan.phoeniix.dev/";
    license = licenses.mit;
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
