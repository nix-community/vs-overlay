{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  vapoursynth,
  numpy,
  poetry-core,
  pytorch,
}:

buildPythonPackage rec {
  pname = "vsgan";
  version = "1.6.4-unstable-2025-02-03";

  src = fetchFromGitHub {
    owner = "rlaphoenix";
    repo = "VSGAN";
    rev = "6f9d76babc6f97b6a17830733c379c5f8c522c31";
    sha256 = "sha256-bMgCah3kkyxNU5tb/eLt0tuG4xnD4sbtAzUK0a4uOKE=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    numpy
    poetry-core
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
    platforms = with platforms; x86_64 ++ aarch64;
  };
}
