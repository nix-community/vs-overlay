{ lib
, fetchFromGitHub
, buildPythonPackage
, python3
  # Needed to explicitly get the VapourSynth *Python* package.
, python3Packages
, numpy
, torch
}:

let
  pythonPackageName = "styler00dollar";
in
buildPythonPackage rec {
  pname = "styler00dollar-vsgan-trt";
  version = "unstable-2022-09-19";

  src = fetchFromGitHub {
    owner = "styler00dollar";
    repo = "VSGAN-tensorrt-docker";
    rev = "cf9c45cdacba9f19b25e26d0e4767bcfe5d48db0";
    sha256 = "sha256-L2HwE5r9OMiuupolJJbvPRIzWIRXc9uDSPC2WTZwWl8=";
  };

  format = "other";

  propagatedBuildInputs = [
    numpy
    torch
    python3Packages.vapoursynth
  ];

  postPatch = ''
    sed --in-place 's/src\./${pythonPackageName}./' convert_*_to_onnx.py
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/${python3.sitePackages}
    # "src" is the actual name of the subdirectory from upstream.
    cp -r src $out/${python3.sitePackages}/${pythonPackageName}

    mkdir -p $out/examples
    cp convert_*_to_onnx.py $out/examples

    runHook postInstall
  '';

  meta = with lib; {
    description = "VSGAN utility modules from styler00dollar";
    longDescription = ''
      Various utility modules by styler00dollar for working with TensorRT.

      This can be used to convert ESRGAN models to to ONXX models, which is
      required if you want to use ESRGAN models with TensorRT.
    '';
    homepage = "https://github.com/styler00dollar/VSGAN-tensorrt-docker";
    license = licenses.bsd3;
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
