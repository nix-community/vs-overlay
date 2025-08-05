{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "adaptivegrain";
  version = "1c062e6dd08dddd10b2933e4f4b8fbba27477969";

  src = fetchFromGitHub {
    repo = pname;
    owner = "Irrational-Encoding-Wizardry";
    rev = version;
    hash = "sha256-mThtNqAnImgMBAT808mwgQ5IlzrtTkaF6gEVdyzTEps=";
  };

  cargoHash = "sha256-drX4YpFieBc142zuwbpK6wgPuVreH85s4zH+bqriCA8=";

  postInstall = ''
    mkdir $out/lib/vapoursynth
    mv $out/lib/libadaptivegrain_rs.so $out/lib/vapoursynth/libadaptivegrain_rs.so
  '';

  meta = with lib; {
    description = "Reimplementation of the adaptive_grain mask as a Vapoursynth plugin";
    homepage = "https://git.kageru.moe/kageru/adaptivegrain";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
