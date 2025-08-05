{ nixpkgs, ... }:
let
  inherit (nixpkgs) lib;
in
lib.mapAttrs (system: platform: lib.systems.elaborate platform) {
  "x86_64-linux" = {
    system = "x86_64-linux";
  };

  "aarch64-linux" = {
    system = "aarch64-linux";
  };

  "i686-linux" = {
    system = "i686-linux";
  };
}
