{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, rich, toolz, vapoursynth, pythonOlder }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    adaptivegrain
    combmask
    continuityfixer
    d2vsource
    descale
    eedi3m
    fmtconv
    knlmeanscl
    nnedi3
    readmpls
    retinex
    #rgsf
    tcanny
    znedi3
  ];
in
buildPythonPackage rec {
  pname = "lvsfunc";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Yv7WBr9suuYsDI9LfZVcTBuDTPkd/DMCk/lQ58qsLyw=";
  };

  postPatch = ''
    # This does not depend on vapoursynth (since this is used from within
    # vapoursynth).
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=51" "" \
  '';

  propagatedBuildInputs = [
    rich
    toolz
  ] ++ (with vapoursynthPlugins; [
    debandshit
    edi_rpow2
    havsfunc
    kagefunc
    mvsfunc
    vsTAAmbk
    vsutil
  ]);

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  pythonImportsCheck = [ "lvsfunc" ];

  meta = with lib; {
    description = "A collection of LightArrowsEXE’s VapourSynth functions and wrappers";
    homepage = "https://lvsfunc.readthedocs.io";
    license = licenses.mit; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
    broken = pythonOlder "3.10";
  };
}
