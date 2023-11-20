# A Nix shell with VapourSynth and all plugins (from this overlay).  Used for
# testing that all plugins in this overlay build.
{vs-overlay}: let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
    overlays = [(import vs-overlay)];
    # Force default Python to 3.x
    config.packageOverrides = pkgs: {
      python = pkgs.python3;
    };
  };
in
  # TODO: Fix broken packages, which are commented out below.
  pkgs.mkShell {
    packages = [
      (pkgs.vapoursynth.withPlugins [
        pkgs.vapoursynthPlugins.adaptivegrain
        pkgs.vapoursynthPlugins.addgrain
        pkgs.vapoursynthPlugins.autocrop
        pkgs.vapoursynthPlugins.awarpsharp2
        pkgs.vapoursynthPlugins.bestaudiosource
        pkgs.vapoursynthPlugins.beziercurve
        pkgs.vapoursynthPlugins.bifrost
        pkgs.vapoursynthPlugins.bilateral
        pkgs.vapoursynthPlugins.bm3d
        pkgs.vapoursynthPlugins.cas
        pkgs.vapoursynthPlugins.cnr2
        pkgs.vapoursynthPlugins.combmask
        pkgs.vapoursynthPlugins.continuityfixer
        pkgs.vapoursynthPlugins.ctmf
        # pkgs.vapoursynthPlugins.d2vsource
        pkgs.vapoursynthPlugins.dctfilter
        pkgs.vapoursynthPlugins.deblock
        pkgs.vapoursynthPlugins.decross
        pkgs.vapoursynthPlugins.descale
        pkgs.vapoursynthPlugins.dfttest
        pkgs.vapoursynthPlugins.eedi2
        pkgs.vapoursynthPlugins.eedi3m
        # pkgs.vapoursynthPlugins.f3kdb
        pkgs.vapoursynthPlugins.ffms2
        pkgs.vapoursynthPlugins.fft3dfilter
        pkgs.vapoursynthPlugins.fillborders
        pkgs.vapoursynthPlugins.fluxsmooth
        pkgs.vapoursynthPlugins.fmtconv
        pkgs.vapoursynthPlugins.histogram
        pkgs.vapoursynthPlugins.hqdn3d
        pkgs.vapoursynthPlugins.imwri
        pkgs.vapoursynthPlugins.knlmeanscl
        # pkgs.vapoursynthPlugins.lsmashsource
        pkgs.vapoursynthPlugins.median
        pkgs.vapoursynthPlugins.minideen
        pkgs.vapoursynthPlugins.miscfilters-obsolete
        pkgs.vapoursynthPlugins.motionmask
        pkgs.vapoursynthPlugins.msmoosh
        pkgs.vapoursynthPlugins.mvtools
        pkgs.vapoursynthPlugins.nnedi3
        pkgs.vapoursynthPlugins.nnedi3cl
        pkgs.vapoursynthPlugins.ocr
        # pkgs.vapoursynthPlugins.placebo
        pkgs.vapoursynthPlugins.readmpls
        pkgs.vapoursynthPlugins.remap
        pkgs.vapoursynthPlugins.removegrain
        pkgs.vapoursynthPlugins.retinex
        pkgs.vapoursynthPlugins.sangnom
        pkgs.vapoursynthPlugins.scxvid
        pkgs.vapoursynthPlugins.subtext
        pkgs.vapoursynthPlugins.tcanny
        pkgs.vapoursynthPlugins.temporalmedian
        pkgs.vapoursynthPlugins.temporalsoften2
        pkgs.vapoursynthPlugins.tnlmeans
        pkgs.vapoursynthPlugins.ttempsmooth
        pkgs.vapoursynthPlugins.vivtc
        # Requires non-redistributable unfree TensorRT.
        # pkgs.vapoursynthPlugins.vstrt
        pkgs.vapoursynthPlugins.wwxd
        pkgs.vapoursynthPlugins.znedi3

        pkgs.vapoursynthPlugins.acsuite
        pkgs.vapoursynthPlugins.adjust
        pkgs.vapoursynthPlugins.astdr
        # pkgs.vapoursynthPlugins.awsmfunc
        # pkgs.vapoursynthPlugins.debandshit
        pkgs.vapoursynthPlugins.dfmderainbow
        pkgs.vapoursynthPlugins.edi_rpow2
        pkgs.vapoursynthPlugins.finedehalo
        pkgs.vapoursynthPlugins.fvsfunc
        pkgs.vapoursynthPlugins.havsfunc
        pkgs.vapoursynthPlugins.kagefunc
        # pkgs.vapoursynthPlugins.lvsfunc
        pkgs.vapoursynthPlugins.mt_lutspa
        pkgs.vapoursynthPlugins.muvsfunc
        pkgs.vapoursynthPlugins.mvsfunc
        pkgs.vapoursynthPlugins.nnedi3_resample
        pkgs.vapoursynthPlugins.nnedi3_rpow2
        # pkgs.vapoursynthPlugins.rekt
        # pkgs.vapoursynthPlugins.vardefunc
        # pkgs.vapoursynthPlugins.vsTAAmbk
        pkgs.vapoursynthPlugins.vsgan
        pkgs.vapoursynthPlugins.vsutil
      ])
    ];
  }
