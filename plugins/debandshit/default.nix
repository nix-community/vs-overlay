{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    f3kdb
    fmtconv
    #rgsf
  ];
in
buildPythonPackage rec {
  pname = "debandshit";
  version = "unstable-2020-05-28";

  src = fetchFromGitHub {
    owner = "LightArrowsEXE";
    repo = pname;
    rev = "d5529c97cdd7f01dcc261d6e79b2aa63b3758cbe";
    sha256 = "0gwpjglm74y6a7x9ws7is7algnwm3i0ds65nz3ki8faigx1jh52a";
  };

  propagatedBuildInputs = (with vapoursynthPlugins; [
    fvsfunc
    muvsfunc
    mvsfunc
  ]) ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    runHook preInstall
    install -D debandshit.py $out/${python3.sitePackages}/debandshit.py
    runHook postInstall
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  checkPhase = ''
    runHook preCheck
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
    runHook postCheck
  '';
  pythonImportsCheck = [ "debandshit" ];

  meta = with lib; {
    description = "Various debanding tools for VapourSynth";
    homepage = "https://github.com/LightArrowsEXE/debandshit";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
