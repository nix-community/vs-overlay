{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:

buildPythonPackage rec {
  pname = "vsTAAmbk";
  version = "0.8.2";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-fOMx4rEfqXAVds1rnHyP+srS8zSY9rMgRVdo4zZ0GhU=";
  };

  patches = [
    ./0001-Skip-OpenCL-test.patch
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
    install -D vsTAAmbk.py $out/${python.sitePackages}/vsTAAmbk.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
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
