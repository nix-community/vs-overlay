{ lib
, fetchFromGitHub
, buildPythonPackage
, python
, vapoursynthPlugins
, vapoursynth
}:

let
  plugins_native = with vapoursynthPlugins; [
    minideen
    msmoosh
    mvtools
    temporalmedian
    temporalsoften2
  ];
in
buildPythonPackage rec {
  pname = "dfmderainbow";
  version = "unstable-10-17-2022";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = "vapoursynth-dfmderainbow";
    rev = "44dc6545bced8fc25672bdda717943a02c6b5d71";
    sha256 = "sha256-0+DnuQKLaO4AHSK7o0LRpYI1oaYVe8qVgfq1K555afI=";
  };

  format = "other";

  propagatedBuildInputs = plugins_native;

  installPhase = ''
    runHook preInstall

    install -D dfmderainbow.py $out/${python.sitePackages}/dfmderainbow.py

    runHook postInstall
  '';

  checkInputs = [ (vapoursynth.withPlugins plugins_native ) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "dfmderainbow" ];

  meta = with lib; {
    description = "A VapourSynth derainbow function";
    longDescription = ''
      This is a port of the Avisynth function of the same name, version 20140223.
    '';
    homepage = "https://github.com/dubhater/vapoursynth-astdr";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
