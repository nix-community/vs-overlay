{ lib
, stdenv
, fetchFromGitHub
, cmake
, vapoursynth
, cudatoolkit
, cudaPackages
}:

stdenv.mkDerivation rec {
  pname = "vstrt";
  version = "10";

  src = fetchFromGitHub {
    owner = "AmusementClub";
    repo = "vs-mlrt";
    rev = "v${version}";
    sha256 = "sha256-fnnVaWPvT/eqr1WEwyhX8zi26IK3Ndm7UHLkSLI1nFk=";
  };

  sourceRoot = "source/vstrt";

  patches = [
    ./no-git-call-in-cmake.patch
  ];

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    vapoursynth
    cudatoolkit
    cudaPackages.tensorrt
  ];

  cmakeFlags = [
    "-DVCS_TAG=v${version}"
    "-DCMAKE_CXX_FLAGS=-I${vapoursynth}/include/vapoursynth"
    "-DCMAKE_SKIP_RPATH=ON"
  ];

  postInstall = ''
    mkdir $out/lib/vapoursynth
    ln -s $out/lib/libvstrt.so $out/lib/vapoursynth
  '';

  meta = with lib; {
    description = "TensorRT-based GPU Runtime";
    homepage = "https://github.com/AmusementClub/vs-mlrt";
    license = licenses.gpl3;
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}
