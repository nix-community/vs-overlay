final: prev:
let
  # This is required to allow vapoursynth.withPlugins to be used inside python packages,
  # where normally python3Packages.vapoursynth would be used,
  # which only includes the python module without the frameserver.
  callPythonPackage = prev.lib.callPackageWith (final // final.vapoursynth.python3.pkgs // {
    inherit (final) vapoursynth;
  });
in
{
  vapoursynthPlugins = prev.recurseIntoAttrs {
    adaptivegrain = prev.callPackage ./plugins/adaptivegrain { };
    addgrain = prev.callPackage ./plugins/addgrain { };
    autocrop = prev.callPackage ./plugins/autocrop { };
    awarpsharp2 = prev.callPackage ./plugins/awarpsharp2 { };
    bestaudiosource = prev.callPackage ./plugins/bestaudiosource { };
    beziercurve = prev.callPackage ./plugins/beziercurve { };
    bifrost = prev.callPackage ./plugins/bifrost { };
    bilateral = prev.callPackage ./plugins/bilateral { };
    bm3d = prev.callPackage ./plugins/bm3d { };
    cas = prev.callPackage ./plugins/cas { };
    cnr2 = prev.callPackage ./plugins/cnr2 { };
    combmask = prev.callPackage ./plugins/combmask { };
    continuityfixer = prev.callPackage ./plugins/continuityfixer { };
    ctmf = prev.callPackage ./plugins/ctmf { };
    d2vsource = prev.callPackage ./plugins/d2vsource { };
    dctfilter = prev.callPackage ./plugins/dctfilter { };
    deblock = prev.callPackage ./plugins/deblock { };
    descale = prev.callPackage ./plugins/descale { };
    dfttest = prev.callPackage ./plugins/dfttest { };
    eedi2 = prev.callPackage ./plugins/eedi2 { };
    eedi3m = prev.callPackage ./plugins/eedi3m { };
    f3kdb = prev.callPackage ./plugins/f3kdb { };
    ffms2 = prev.ffms;
    fft3dfilter = prev.callPackage ./plugins/fft3dfilter { };
    fillborders = prev.callPackage ./plugins/fillborders { };
    fluxsmooth = prev.callPackage ./plugins/fluxsmooth { };
    fmtconv = prev.callPackage ./plugins/fmtconv { };
    histogram = prev.callPackage ./plugins/histogram { };
    hqdn3d = prev.callPackage ./plugins/hqdn3d { };
    imwri = prev.callPackage ./plugins/imwri { };
    knlmeanscl = prev.callPackage ./plugins/knlmeanscl { };
    lsmashsource = prev.callPackage ./plugins/lsmashsource { };
    median = prev.callPackage ./plugins/median { };
    miscfilters-obsolete = prev.callPackage ./plugins/miscfilters-obsolete { };
    msmoosh = prev.callPackage ./plugins/msmoosh { };
    mvtools = prev.vapoursynth-mvtools;
    nnedi3 = prev.callPackage ./plugins/nnedi3 { };
    nnedi3cl = prev.callPackage ./plugins/nnedi3cl { };
    ocr = prev.callPackage ./plugins/ocr { };
    placebo = prev.callPackage ./plugins/placebo { };
    readmpls = prev.callPackage ./plugins/readmpls { };
    remap = prev.callPackage ./plugins/remap { };
    removegrain = prev.callPackage ./plugins/removegrain { };
    retinex = prev.callPackage ./plugins/retinex { };
    sangnom = prev.callPackage ./plugins/sangnom { };
    scxvid = prev.callPackage ./plugins/scxvid { };
    subtext = prev.callPackage ./plugins/subtext { };
    tcanny = prev.callPackage ./plugins/tcanny { };
    tnlmeans = prev.callPackage ./plugins/tnlmeans { };
    ttempsmooth = prev.callPackage ./plugins/ttempsmooth { };
    vivtc = prev.callPackage ./plugins/vivtc { };
    wwxd = prev.callPackage ./plugins/wwxd { };
    znedi3 = prev.callPackage ./plugins/znedi3 { };

    acsuite = callPythonPackage ./plugins/acsuite { };
    adjust = callPythonPackage ./plugins/adjust { };
    debandshit = callPythonPackage ./plugins/debandshit { };
    edi_rpow2 = callPythonPackage ./plugins/edi_rpow2 { };
    finedehalo = callPythonPackage ./plugins/finedehalo { };
    mt_lutspa = callPythonPackage ./plugins/mt_lutspa { };
    nnedi3_resample = callPythonPackage ./plugins/nnedi3_resample { };
    nnedi3_rpow2 = callPythonPackage ./plugins/nnedi3_rpow2 { };
    rekt = callPythonPackage ./plugins/rekt { };
    vsgan = callPythonPackage ./plugins/vsgan { };
    vsTAAmbk = callPythonPackage ./plugins/vsTAAmbk { };
    vsutil = callPythonPackage ./plugins/vsutil { };

    awsmfunc = callPythonPackage ./plugins/awsmfunc { };
    fvsfunc = callPythonPackage ./plugins/fvsfunc { };
    havsfunc = callPythonPackage ./plugins/havsfunc { };
    kagefunc = callPythonPackage ./plugins/kagefunc { };
    lvsfunc = callPythonPackage ./plugins/lvsfunc { };
    muvsfunc = callPythonPackage ./plugins/muvsfunc { };
    mvsfunc = callPythonPackage ./plugins/mvsfunc { };
    vardefunc = callPythonPackage ./plugins/vardefunc { };
  };

  getnative = callPythonPackage ./tools/getnative { };
}
