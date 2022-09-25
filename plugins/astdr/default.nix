{ lib
, fetchFromGitHub
, buildPythonPackage
, python
, vapoursynthPlugins
, vapoursynth
}:

let
  plugins_native = with vapoursynthPlugins; [
    awarpsharp2
    fft3dfilter
    hqdn3d
    mvtools
    ctmf
    fluxsmooth
    decross
    temporalsoften2
    motionmask
  ];
  plugins_python = with vapoursynthPlugins; [
    adjust
  ];
in
buildPythonPackage rec {
  pname = "astdr";
  version = "4";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = "vapoursynth-astdr";
    rev = "v${version}";
    sha256 = "sha256-We3vhTZCGYZPMOAfWGif3yAxBUAPUk9zm9JQdlWhn8E=";
  };

  format = "other";

  propagatedBuildInputs = plugins_native ++ plugins_python;

  installPhase = ''
    runHook preInstall

    install -D ASTDR.py $out/${python.sitePackages}/ASTDR.py

    runHook postInstall
  '';

  checkInputs = [ (vapoursynth.withPlugins plugins_native ) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "ASTDR" ];

  meta = with lib; {
    description = "A VapourSynth derainbow function";
    longDescription = ''
      This is a port of the Avisynth function of the same name, version 1.74.
    '';
    homepage = "https://github.com/dubhater/vapoursynth-astdr";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
