{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  vapoursynth,
}:

buildPythonPackage rec {
  pname = "vsutil";
  version = "0.8.0";

  # there are no tests in the pypi tarball
  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = version;
    sha256 = "sha256-15sf8mLpDUcnidD3n2yQdIQEPA2zYtb/b/h3Sx49VEc=";
  };

  patches = [
    # Vapoursynth is not recognised during installation. Since this package
    # provides tests, a dependency problem should be catched by them.
    ./disable-vapoursynth-install-requirement.diff
    # By default, test failure does not fail the build.
    ./fail-tests.diff
  ];

  checkInputs = [ vapoursynth ];

  meta = with lib; {
    description = "A collection of general purpose Vapoursynth functions to be reused in modules and scripts";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vsutil";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
