{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python3, vapoursynth }:

buildPythonPackage rec {
  pname = "mvsfunc";
  version = "r10";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = version;
    sha256 = "sha256-J68NMBE3MdAd9P0UJH32o0YwQx+7I5+13j8Jc5rbQtc=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    bm3d
    fmtconv
  ];

  format = "other";

  installPhase = ''
    install -D mvsfunc.py $out/${python3.sitePackages}/mvsfunc.py
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "mvsfunc" ];

  meta = with lib; {
    description = "mawen1250’s VapourSynth functions";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/mvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
