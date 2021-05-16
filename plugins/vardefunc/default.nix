{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    adaptivegrain
    bilateral
    eedi3m
    f3kdb
    ffms2
    nnedi3cl
    scxvid
    wwxd
  ];
in
buildPythonPackage rec {
  pname = "vardefunc";
  version = "1.1.4";

  src = fetchFromGitHub {
    owner = "Ichunjo";
    repo = pname;
    rev = "v${version}";
    sha256 = "0bkchcshxmfcfbqapw367y3cfj1rdz78a55fkcvznvy61fhqvzl7";
  };

  propagatedBuildInputs = (with vapoursynthPlugins; [
    fvsfunc
    havsfunc
    lvsfunc
    vsutil
  ]) ++ propagatedBinaryPlugins;

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=51" ""
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  pythonImportsCheck = [ "vardefunc" ];

  meta = with lib; {
    description = " Some functions that may be useful ";
    homepage = "https://github.com/Ichunjo/vardefunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
