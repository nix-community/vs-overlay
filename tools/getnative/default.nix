{
  lib,
  vapoursynth,
  vapoursynthPlugins,
  buildPythonApplication,
  fetchFromGitHub,
  matplotlib,
  imagemagick,
}:
let
  vapoursynth-with-plugins = vapoursynth.withPlugins (
    with vapoursynthPlugins;
    [
      ffms2
      descale
    ]
  );
in
buildPythonApplication rec {
  pname = "getnative";
  version = "3.2.1-unstable-2023-12-31";

  src = fetchFromGitHub {
    owner = "Infiziert90";
    repo = pname;
    # The version in setup.py is 3.0.2, but there is no tag for it
    # (the tag that GitHub shows as 3.0.2 actually is 3.0.0)
    rev = "720c3953d7668d0d5daf8abf827d63b3936d6d2b";
    sha256 = "sha256-TJxMZ1UlP/lxX7VHLF75V+fop8R910yGFNpu4Xbtqkc=";
  };

  # vapoursynth is not recognised during installation
  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=55" ""
  '';

  propagatedBuildInputs = [
    matplotlib
    vapoursynth-with-plugins
  ];

  nativeCheckInputs = [
    imagemagick
  ];
  checkInputs = [
    vapoursynth-with-plugins
  ];
  checkPhase = ''
    convert -size 1280x720 canvas: +noise Random test.png
    $out/bin/getnative --min-height 699 --max-height 700 test.png
    $out/bin/getnative --min-height 699 --max-height 700 -u ffms2.Source test.png
  '';

  meta = with lib; {
    description = "A cli tool to find the native resolution(s) of upscaled material (mostly anime)";
    homepage = "https://github.com/Infiziert90/getnative";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
