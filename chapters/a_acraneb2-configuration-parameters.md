\appendix

ACRANEB2 Configuration Parameters
=================================

This appendix documents some of the configuration parameters used in the
ACRANEB2 radiation scheme, esp. those relevant to computational
intermittency.
The parameters are set as variables in a Fortran namelist supplied to
the SCM (single column model) or the NWP model ALADIN.
More configuration parameters are documented briefly in `Arp/module/yomphy.F90`
in the ALADIN source code.

## Intermittency Parameters

### NSORAYFR

    NSORAYFR=<n>
    NSORAYFR=-<h>

Shortwave (solar) intermittency interval length.
Shortwave gaseus transmissivities are calculated every
`<n>` steps, resp. every `<h>` hours.

### NRAUTOEV

    NRAUTOEV=<n>

Intermittency interval of calculation of NER ‘bracketing’
weights in the thermal (longwave) computation. Weights are calculated
every `<n>` full radiation steps, or disabled when `<n>` = 0.

### LRAYPL

    LRAYPL=.T.|.F.

Turn on or off day/night slicing of grid blocks. If enabled, shortwave
computation is restricted to ‘day’ grid cells, possibly improving performance.

### NTHRAYFR

    NTHRAYFR=<n>
    NTHRAYFR=-<h>

Longwave (thermal) intermittency interval length.
Longwave gaseous transmissivities are calculated every
`<n>` steps, resp. every `<h>` hours.
