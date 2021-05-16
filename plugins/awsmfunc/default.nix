{ lib, vapoursynthPlugins, buildPythonPackage, fetchgit, numpy, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    descale
    fillborders
    placebo
    remap
  ];
in
buildPythonPackage rec {
  pname = "awsmfunc";
  version = "unstable-2021-01-26";

  src = fetchgit {
    url = "https://git.concertos.live/AHD/awsmfunc.git";
    rev = "e57ad6a976d059ffcf8ae59ee986bdbefef53cd0";
    sha256 = "0j2gzxcz3sy0h7r5a1dhl6xjgjd2m66mw4kfm8q2glar5b7gn0k7";
  };

  # This does not depend on vapoursynth (since this is used from within
  # vapoursynth).
  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=49" "" \
        --replace "rekt@https://gitlab.com/Ututu/rekt/-/archive/3da2b2f2b2d670e635cef6dcc61f19c8fe10f1fa/rekt-3da2b2f2b2d670e635cef6dcc61f19c8fe10f1fa.zip" "rekt"
  '';

  propagatedBuildInputs = [
    numpy
  ] ++ (with vapoursynthPlugins; [
    rekt
    vsutil
  ]);

  checkInputs = [ (vapoursynth.withPlugins propagatedBinaryPlugins) ];
  pythonImportsCheck = [ "awsmfunc" ];

  meta = with lib; {
    description = "A VapourSynth function collection";
    homepage = "https://git.concertos.live/AHD/awsmfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
