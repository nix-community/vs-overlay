{ lib, buildPythonPackage, setuptools, fetchFromGitHub, vapoursynthPlugins, vapoursynth }:

buildPythonPackage rec {
  pname = "rekt";
  version = "1.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "OpusGang";
    repo = pname;
    rev = version;
    sha256 = "sha256-SWu7W0DFoPLeTe4+aYQGUlaU0n63W3IB7Fdi71uqyzw=";
  };

  propagatedBuildInputs = [
    setuptools
    vapoursynthPlugins.vsutil
  ];

  checkInputs = [ vapoursynth ];
  pythonImportsCheck = [ "rekt" ];

  meta = with lib; {
    description = "VapourSynth wrapper for Cropping and Stacking clips";
    homepage = "https://github.com/OpusGang/rekt";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
