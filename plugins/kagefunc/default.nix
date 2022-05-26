{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    adaptivegrain
    addgrain
    bm3d
    descale
    fmtconv
    knlmeanscl
    retinex
    tcanny
    wwxd
  ];
in
buildPythonPackage rec {
  pname = "kagefunc";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = version;
    sha256 = "sha256-9OpFSVLQspa6+xkCFqD5xeo3akCfwnpwtFuCCsQxAvQ=";
  };

  patches = [
    ./skip-opencl-test.diff
  ];

  propagatedBuildInputs = (with vapoursynthPlugins; [
    fvsfunc
    mvsfunc
    vsutil
  ]) ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D kagefunc.py $out/${python.sitePackages}/kagefunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
    python3 tests.py
  '';
  pythonImportsCheck = [ "kagefunc" ];

  meta = with lib; {
    description = "A collection of Vapoursynth functions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/kagefunc";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
