{ lib, fetchFromGitHub, runCommand, stdenv, meson, ninja, makeWrapper, pkg-config, vapoursynth, vapoursynthPlugins, ffmpeg_4, qtbase, qttools, wrapQtAppsHook }:
let
  vapoursynthWithPlugins = vapoursynth.withPlugins (with vapoursynthPlugins; [ d2vsource ]);
  unwrapped = stdenv.mkDerivation rec {
    name = "D2VWitch";
    version = "5";

    src = fetchFromGitHub {
      owner = "dubhater";
      repo = name;
      rev = "v${version}";
      sha256 = "sha256-9JIfLkxYgEuZx2WE6Tjq+KgWmJark+D2O/fen5K6slk=";
    };

    nativeBuildInputs = [ meson ninja pkg-config wrapQtAppsHook qttools ];
    buildInputs = [ vapoursynthWithPlugins ffmpeg_4 qtbase ];
    meta = with lib; {
      description = "writes D2V files";
      homepage = "https://github.com/dubhater/D2VWitch";
      license = licenses.unfree; # no license
      platforms = [ "x86_64-linux" ];
      maintainers = with maintainers; [ ];
    };
  };
  wrapped = runCommand "${unwrapped.name}-wrapped" {
    buildInputs = [ makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${unwrapped}/bin/d2vwitch $out/bin/d2vwitch \
        --prefix LD_LIBRARY_PATH : ${vapoursynthWithPlugins}/lib
  '';
in
  wrapped
