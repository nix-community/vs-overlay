# vs-overlay

A collection of packages (mostly plugins) related to using VapourSynth with Nix.

### Standalone Nix

Add the repository to `~/.config/nixpkgs/overlays.nix`:

```nix
[
  (import (builtins.fetchTarball "https://github.com/nix-community/vs-overlay/archive/master.tar.gz"))
]
```

### NixOS, without flakes

Add the repository to the `nixpkgs.overlays` option of `configuration.nix`:

```nix
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball "https://github.com/nix-community/vs-overlay/archive/master.tar.gz"))
  ];
}
```

### NixOS, with flakes

> Note: Flakes are an experimental feature of Nix.  
> If you're not already using them, you should follow [NixOS, without flakes](#nixos-without-flakes) instead.

> Note: This only fetches the overlay as a flake,
> it doesn't use the pinned Nixpkgs version.  
> See [Usage as a flake](#usage-as-a-flake) for more information.

In `flake.nix`, add `vs-overlay` as an input:

```nix
{
  inputs.vs-overlay.url = "github:nix-community/vs-overlay";
}
```

Then add `vs-overlay.overlay` to `nixpkgs.overlays`:

```nix
{
  nixpkgs.overlays = [
    vs-overlay.overlay
  ];
}
```

## Usage

Adding the repository as an overlay will add the packages to the main `pkgs` set,
using them is the same as packages from Nixpkgs:

### Manually building

```sh
# Build a standalone package
nix-build '<nixpkgs>' -A getnative

# Build a VSEdit package with the given plugins
nix-build -E '
  { pkgs ? import <nixpkgs> {} }:
  with pkgs;
  vapoursynth-editor.withPlugins [
    vapoursynthPlugins.mvtools
    vapoursynthPlugins.vsutil
  ]
'
```

### NixOS config

```nix
{
  environment.systemPackages = with pkgs; [
    # Standalone package from this overlay
    getnative

    # Vapoursynth (from Nixpkgs) with plugins
    (vapoursynth.withPlugins [
        vapoursynthPlugins.mvtools
    ])

    # VSEdit (from Nixpkgs) with plugins
    (vapoursynth-editor.withPlugins [
        vapoursynthPlugins.vsutil
    ])
  ];
}
```

## Usage as a flake

> Note: [Flakes](https://nixos.wiki/wiki/Flakes) are an experimental Nix feature intended to improve reproducibility.
>
> When this repository is used as a flake,
> it uses a pinned version of Nixpkgs rather than the system set.  
> This has both advantages and disadvantages:
> a newer revision of Nixpkgs could have an important fix for a plugin dependency,
> but an update could also break a plugin due to backwards-incompatible changes.

### Setup

In `flake.nix`, add `vs-overlay` as an input:

```nix
{
  inputs.vs-overlay.url = "github:nix-community/vs-overlay";
}
```

### Usage

Packages are accessible through `vs-overlay.packages.<system>`:

```nix
{
  environment.systemPackages = with pkgs; [
    vs-overlay.packages.x86_64-linux.getnative

    (vapoursynth.withPlugins [
      vs-overlay.packages.x86_64-linux.vapoursynthPlugins.vsutil
    ])
  ];
}
```

# License

Like Nixpkgs itself, this repository uses the MIT license.  
It only applies to the files in this repository,
not the results of building the packages.
