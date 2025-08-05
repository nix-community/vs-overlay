{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  vapoursynth,
  python312,
}:

# required to make python.buildEnv use descale’s python module
python312.pkgs.toPythonModule (
  stdenv.mkDerivation (finalAttrs: {
    pname = "vapoursynth-descale";
    version = "r8-unstable-2023-04-02";

    src = fetchFromGitHub {
      owner = "Irrational-Encoding-Wizardry";
      repo = finalAttrs.pname;
      rev = "master";
      sha256 = "sha256-dobooNxoDH1MBQtycfiZTE3xy7j5fCGhD9cnPGGZocc=";
    };

    nativeBuildInputs = [
      meson
      ninja
      pkg-config
    ];
    buildInputs = [ vapoursynth ];

    postPatch = ''
      substituteInPlace meson.build \
          --replace "vs.get_pkgconfig_variable('libdir')" "get_option('libdir')"
    '';

    postInstall = ''
      install -D ../descale.py $out/${python312.sitePackages}/descale.py
    '';

    meta = with lib; {
      description = "VapourSynth plugin to undo upscaling";
      homepage = "https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale";
      license = licenses.wtfpl;
      maintainers = with maintainers; [ sbruder ];
      platforms = platforms.all;
    };
  })
)
