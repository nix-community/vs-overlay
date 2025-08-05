{
  description = "vs-overlay";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  nixConfig = {
    extra-substituters = [
      "https://cache.kyouma.net"
    ];
    extra-trusted-public-keys = [
      "cache.kyouma.net:Frjwu4q1rnwE/MnSTmX9yx86GNA/z3p/oElGvucLiZg="
    ];
    builders-use-substitutes = true;
  };

  outputs =
    { self, nixpkgs }@inputs:
    let
      inherit (nixpkgs) lib;
      buildPlatforms = import ./lib/platforms.nix inputs;
      eachSystem = uwu: lib.mapAttrs uwu buildPlatforms;
      pkgs = eachSystem (
        system: _:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
        }
      );

    in
    {
      overlays.default = import ./default.nix;
      formatter = eachSystem (system: _: pkgs.${system}.nixfmt-tree);

      packages = eachSystem (
        system: platform:
        lib.filterAttrs (_: pkg: lib.meta.availableOn platform pkg) (
          {
            inherit (pkgs.${system}) getnative;
          }
          // lib.filterAttrs (_: lib.isDerivation) pkgs.${system}.vapoursynthPlugins
        )
      );

      hydraJobs = { inherit (self) packages; };
    };
}
