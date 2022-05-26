{ lib, buildPythonPackage, fetchFromGitHub, fetchpatch, python, vapoursynth }:

buildPythonPackage rec {
  pname = "vapoursynth-adjust";
  version = "1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "0wd6sh788ljb4vj6fd5zv2cx7nl6x1k3lnz44n7p3ac5vfskjz8a";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/dubhater/vapoursynth-adjust/commit/a3af7cb57cb37747b0667346375536e65b1fed17.patch";
      sha256 = "sha256-0N7oSsYj0/F0PwswI+1hgM7Gu1KKWdlJOuYf24wlEUw=";
    })
  ];

  format = "other";

  installPhase = ''
    install -D adjust.py $out/${python.sitePackages}/adjust.py
  '';

  checkInputs = [ vapoursynth ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "adjust" ];

  meta = with lib; {
    description = "A VapourSynth port of the Avisynth filter Tweak";
    homepage = "https://github.com/dubhater/vapoursynth-adjust";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
