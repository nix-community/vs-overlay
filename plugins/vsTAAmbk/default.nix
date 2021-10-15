{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python3, vapoursynth }:

buildPythonPackage rec {
  pname = "vsTAAmbk";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-KfU2f7tBhw007f4RmVruV3Pkgo1zdA4o43+1lL/ohKo=";
  };

  patches = [
    ./0001-Skip-OpenCL-test.patch
    ./0002-Use-format-IDs-from-VapourSynth-R55.patch
  ];

  propagatedBuildInputs = with vapoursynthPlugins; [
    awarpsharp2
    cas
    eedi2
    eedi3m
    fmtconv
    havsfunc
    msmoosh
    mvsfunc
    mvtools
    nnedi3
    nnedi3cl
    removegrain
    sangnom
    tcanny
    znedi3
  ];

  format = "other";

  installPhase = ''
    install -D vsTAAmbk.py $out/${python3.sitePackages}/vsTAAmbk.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
    python3 test/vsTAAmbkTestCase.py
  '';

  meta = with lib; {
    description = "An Anti-aliasing script for VapourSynth ported from Avisynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/vsTAAmbk";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
