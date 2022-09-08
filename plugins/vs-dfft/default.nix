{ lib, vapoursynthPlugins, buildPythonPackage, fetchFromGitHub, python3, vapoursynth, numpy, pyfftw }:
buildPythonPackage rec {
  pname = "vs-dfft";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-55QkAj2uUwTbSItOxcVDybO929566mqxJyKFXkGVwQw=";
  };

  propagatedBuildInputs = [ numpy pyfftw ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=59" ""
  '';

  checkPhase = ''
    PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  '';

  meta = with lib; {
    description = "Collection of Discrete/Fast Fourier Transform VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-dfft";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
