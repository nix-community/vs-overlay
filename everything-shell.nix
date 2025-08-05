# A Nix shell with VapourSynth and all plugins (from this overlay).  Used for
# testing that all plugins in this overlay build.
{ vs-overlay }:
let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
    overlays = [ (import vs-overlay) ];
    # Force default Python to 3.x
    config.packageOverrides = pkgs: {
      python = pkgs.python3;
    };
  };
in
# TODO: Fix broken packages, which are commented out below.
pkgs.mkShell {
  packages = [
    (pkgs.vapoursynth.withPlugins (
      with pkgs.vapoursynthPlugins;
      [
        adaptivegrain
        addgrain
        autocrop
        awarpsharp2
        beziercurve
        bifrost
        bilateral
        bm3d
        cas
        cnr2
        combmask
        continuityfixer
        ctmf
        d2vsource
        dctfilter
        deblock
        decross
        descale
        dfttest
        eedi2
        eedi3m
        ffms2
        fft3dfilter
        fillborders
        fluxsmooth
        fmtconv
        histogram
        hqdn3d
        imwri
        knlmeanscl
        lsmashsource
        median
        minideen
        miscfilters-obsolete
        motionmask
        msmoosh
        mvtools
        neo_f3kdb
        nnedi3
        nnedi3cl
        ocr
        placebo
        readmpls
        remap
        removegrain
        retinex
        sangnom
        scxvid
        subtext
        tcanny
        temporalmedian
        temporalsoften2
        tnlmeans
        ttempsmooth
        vivtc
        # Requires non-redistributable unfree TensorRT.
        # vstrt
        wwxd
        znedi3

        acsuite
        adjust
        astdr
        awsmfunc
        # debandshit
        dfmderainbow
        edi_rpow2
        finedehalo
        fvsfunc
        havsfunc
        kagefunc
        # lvsfunc
        mt_lutspa
        muvsfunc
        mvsfunc
        nnedi3_resample
        nnedi3_rpow2
        rekt
        # vardefunc
        # vsTAAmbk
        vsgan
        vsutil
      ]
    ))
  ];
}
