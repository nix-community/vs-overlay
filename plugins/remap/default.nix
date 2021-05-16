{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "Vapoursynth-RemapFrames";
  version = "1.1";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "v${version}";
    sha256 = "1ki5yvlrw1x3hr3jb9mi7va66kl6lq5f2aynylz5lsx2f14iavra";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "Vapoursynth port of RemapFrames";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-RemapFrames";
    license = licenses.bsd2;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
