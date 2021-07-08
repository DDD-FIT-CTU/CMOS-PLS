# Changelog

## MICREL 2021 version
  * there was an error in SUBCKT_Iph_nplus_psub used in NMOS source (XcsrcS) model; as it produced current in a wrong direction
  * models were corrected so the shared area in the stack is not a problem anymore; source or drain area can be assigned to any of neighbouring transistor and the simulation output will be consistent: "commonDrain" and "commonSource" attributes are no longer required; this explanation is now deprecated: [models docs](doc/MODELS.md)
  * thus models exported from Magic layout tool can be used directly - without any modiffication
  * constant current offset for models when the pLaser is 0 was fixed
  * SBOX models added and evaluation resources are provided

## DDECS2020 version
  * models ([models.lib](models.lib)) were altered to closely reflect the reality -- see [models docs](doc/MODELS.md)
  * attack-resistant structures were designed and evaluated -- see the [test-set description](resistantGates/README.md) -- described in paper [C]
  * subthreshold Leakage [model](tests/test014_nmosSubthresholdLeakage.gnuplot) and [SPICE simulation](tests/test014_nmosSubthresholdLeakage.spice) were added into the [tests](tests/README.md) directory
  * additional minor fixes

## DSD2019 version

  * in DDECS2019 version, PN junction areas were given as additional parameters (layout hand measurement), now technology parameters ad/as were used 
  * authors of referenced papers used (probably) the "projection" of the area, not the "surface", but their transistors are huge, thus the relative difference is (in case) small
  * in 180nm and below, the diference is signifficant, but still influences mainly the absolute current value(s), not the releation(s), so the deduced results (published in DDECS2019 paper) remain correct
  * using ad/as params simplifies new gate model addition and it does not influence data-dependency (experiment validity)

  * the SUBCKT_Iph_Psub_Nwell has been moved from P-transistor to the top circuit netlist to reflect Pplus/Nwell relation for whole circuit at one place; in most places it is disabled, as it does not generate data-deúpendent current
  * in DDECS2019 version, bad area (too big) of PN junction was used leading to about 3-times bigger value of the photocurent. Current relations and data-dependence remains the same -> results published in DDECS2019 paper remains correct, while absolute current values are too big
