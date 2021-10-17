{ lib, buildPythonPackage, fetchFromGitHub, fetchpatch, vapoursynth }:

buildPythonPackage rec {
  pname = "vsutil";
  version = "unstable-2021-10-23";

  # there are no tests in the pypi tarball
  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "a101f22b7be4f28bc89ed73bfc82cce3067dc549";
    sha256 = "sha256-IQncZxpd2QNYmjMXxE++yeY4mDffBjOtE69J2lQPQUU=";
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
