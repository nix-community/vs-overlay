{ lib, buildPythonPackage, fetchgit, vapoursynthPlugins, python3, vapoursynth }:

buildPythonPackage rec {
  pname = "finedehalo";
  version = "unstable-2016-07-08";

  src = fetchgit {
    url = "https://gist.github.com/bcd427ec0fa8fdf7c45433917521bac4.git";
    rev = "879cd79512d8f43083bcc7832890649aaf4d49fe";
    sha256 = "0iq8hjwab9lmyaa49k03pi64fw34hdv6xr33s9kyjn6f9j2dn8b5";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    havsfunc
    mvsfunc
  ];

  format = "other";

  installPhase = ''
    runHook preInstall
    install -D finedehalo.py $out/${python3.sitePackages}/finedehalo.py
    runHook postInstall
  '';

  checkInputs = [ vapoursynth ];
  checkPhase = ''
    runHook preCheck
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
    runHook postCheck
  '';
  pythonImportsCheck = [ "finedehalo" ];

  meta = with lib; {
    description = "FineDehalo ported to VapourSynth";
    homepage = "https://forum.doom9.org/showthread.php?t=173672";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
