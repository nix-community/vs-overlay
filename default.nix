self: super:
let
  callPythonPackage = super.vapoursynth.python3.pkgs.callPackage;
in
{
  vapoursynthPlugins = super.recurseIntoAttrs {
    adaptivegrain = super.callPackage ./plugins/adaptivegrain { };
    addgrain = super.callPackage ./plugins/addgrain { };
    autocrop = super.callPackage ./plugins/autocrop { };
    awarpsharp2 = super.callPackage ./plugins/awarpsharp2 { };
    beziercurve = super.callPackage ./plugins/beziercurve { };
    bifrost = super.callPackage ./plugins/bifrost { };
    bilateral = super.callPackage ./plugins/bilateral { };
    bm3d = super.callPackage ./plugins/bm3d { };
    cas = super.callPackage ./plugins/cas { };
    cnr2 = super.callPackage ./plugins/cnr2 { };
    continuityfixer = super.callPackage ./plugins/continuityfixer { };
    ctmf = super.callPackage ./plugins/ctmf { };
    dctfilter = super.callPackage ./plugins/dctfilter { };
    deblock = super.callPackage ./plugins/deblock { };
    descale = super.callPackage ./plugins/descale { };
    dfttest = super.callPackage ./plugins/dfttest { };
    eedi2 = super.callPackage ./plugins/eedi2 { };
    eedi3m = super.callPackage ./plugins/eedi3m { };
    f3kdb = super.callPackage ./plugins/f3kdb { };
    ffms2 = super.ffms;
    fft3dfilter = super.callPackage ./plugins/fft3dfilter { };
    fluxsmooth = super.callPackage ./plugins/fluxsmooth { };
    fmtconv = super.callPackage ./plugins/fmtconv { };
    histogram = super.callPackage ./plugins/histogram { };
    hqdn3d = super.callPackage ./plugins/hqdn3d { };
    knlmeanscl = super.callPackage ./plugins/knlmeanscl { };
    lsmashsource = super.callPackage ./plugins/lsmashsource { };
    median = super.callPackage ./plugins/median { };
    msmoosh = super.callPackage ./plugins/msmoosh { };
    mvtools = super.vapoursynth-mvtools;
    nnedi3 = super.callPackage ./plugins/nnedi3 { };
    nnedi3cl = super.callPackage ./plugins/nnedi3cl { };
    placebo = super.callPackage ./plugins/placebo { };
    retinex = super.callPackage ./plugins/retinex { };
    sangnom = super.callPackage ./plugins/sangnom { };
    scxvid = super.callPackage ./plugins/scxvid { };
    tcanny = super.callPackage ./plugins/tcanny { };
    tnlmeans = super.callPackage ./plugins/tnlmeans { };
    ttempsmooth = super.callPackage ./plugins/ttempsmooth { };
    wwxd = super.callPackage ./plugins/wwxd { };
    znedi3 = super.callPackage ./plugins/znedi3 { };

    acsuite = callPythonPackage ./plugins/acsuite { };
    adjust = callPythonPackage ./plugins/adjust { };
    debandshit = callPythonPackage ./plugins/debandshit { };
    edi_rpow2 = callPythonPackage ./plugins/edi_rpow2 { };
    mt_lutspa = callPythonPackage ./plugins/mt_lutspa { };
    nnedi3_resample = callPythonPackage ./plugins/nnedi3_resample { };
    nnedi3_rpow2 = callPythonPackage ./plugins/nnedi3_rpow2 { };
    vsTAAmbk = callPythonPackage ./plugins/vsTAAmbk { };
    vsutil = callPythonPackage ./plugins/vsutil { };

    fvsfunc = callPythonPackage ./plugins/fvsfunc { };
    havsfunc = callPythonPackage ./plugins/havsfunc { };
    kagefunc = callPythonPackage ./plugins/kagefunc { };
    muvsfunc = callPythonPackage ./plugins/muvsfunc { };
    mvsfunc = callPythonPackage ./plugins/mvsfunc { };
    vardefunc = callPythonPackage ./plugins/vardefunc { };
  };

  getnative = callPythonPackage ./tools/getnative { };
}
