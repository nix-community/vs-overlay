{ lib, vapoursynthPlugins, buildPythonPackage, setuptools, fetchFromGitHub, numpy, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    descale
    fillborders
    placebo
    remap
  ];
in
buildPythonPackage rec {
  pname = "awsmfunc";
  version = "1.3.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "OpusGang";
    repo = pname;
    rev = version;
    hash = "sha256-7J7s/SdnA5/A/q4SaBfIWG+qOwHpjSrUzWkY1r63wwc=";
  };

  propagatedBuildInputs = [
    setuptools
    numpy
  ] ++ (with vapoursynthPlugins; [
    rekt
    vsutil
  ]);

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  pythonImportsCheck = [ "awsmfunc" ];

  meta = with lib; {
    description = "A VapourSynth function collection";
    homepage = "https://github.com/OpusGang/awsmfunc";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
