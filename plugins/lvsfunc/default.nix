{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, rich, toolz, vapoursynth }:
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
  version = "unstable-2021-05-15";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "76bddb75bc014a47064958beecb13143b8206fa6";
    sha256 = "0gvpz9d0lbjvpk8spkfxbmi4s8pqqyjqi8jjvfhfdf3m906v1wh1";
  };

  postPatch = ''
    # This does not depend on vapoursynth (since this is used from within
    # vapoursynth).
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=51" "" \

    # TODO: remove when python 3.9 is default in nixpkgs
    substituteInPlace setup.py \
        --replace "python_requires='>=3.9'" "python_requires='>=3.8'" \
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
  };
}
