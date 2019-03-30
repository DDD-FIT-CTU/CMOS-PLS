# Photoelectric Laser Stimulation of Conventional Majority Voter
  * this repository contains models used to derive behaviour of Majority Voter under Photoelectric Laser Stimulation (PLS)
  * in paper [A], we argue, that PLS may be used to obtain bits stored in register protected by Voter under PLS
  * this work is based on models defined in **referenced papers**

## Requirements
  * [ngSPICE](http://ngspice.sourceforge.net/) is required for netlists simulatio
  
## Project structure
  * **models.lib** file:
    * contains circuit models used for simulation of PLS
  * **tests** directory:
    * contains tests for particular (sub)circuits
  * **majorityVoter** directory:
    * contains SPICE model of the Conventional majority voter in 180 nm TSMC technology and scripts used for behavioral simulation of voter under PLS

# Transistor Models
  * Transistor models, which are ready-for-simulation are:
    * 180nm [TSMC CMOS models](https://vlsiarch.ecen.okstate.edu/flows/MOSIS_SCMOS)
    * 90nm [Predictive Technology Models](ptm.asu.edu) (modified for ngspice): [http://ptm.asu.edu/modelcard/2006/90nm_bulk.pm](http://ptm.asu.edu/modelcard/2006/90nm_bulk.pm)
      * note: if you use PTM models in your research, you have to cite papers mentioned at the PTM's webpage

# License
  * The content of this repository is released under the (MIT-like) University of Illinois/NCSA Open Source License. See the [LICENSE](LICENSE) file.

# Papers
This repository contains data for experiments described in following papers:
  * [A] Bělohoubek, J.; Fišer, P.; Schmidt, J.: Using Voters May Lead to Secret Leakage. In: Proceedings of the 22nd International Symposium on Design and Diagnostics of Electronic Circuits and Systems (DDECS 2019), April 2019.
 
**If you use data released in this repository for your research, please include the mentioned paper into the list of references.**

# References
  * [1] Alexandre Sarafianos, Olivier Gagliano, Valérie Serradeil, Mathieu Lisart, Jean-Max Dutertre, et al.. Building the electrical model of the pulsed photoelectric laser stimulation of an NMOS transistor in 90nm technology. International Reliability Physics Symposium (IRPS), Apr 2013, Monterey, United States. 2013.
  
  * [2] A. Sarafianos, O. Gagliano, M. Lisart, V. Serradeil, J. Dutertre and A. Tria, "Building the electrical model of the pulsed photoelectric laser stimulation of a PMOS transistor in 90nm technology," Proceedings of the 20th IEEE International Symposium on the Physical and Failure Analysis of Integrated Circuits (IPFA), Suzhou, 2013, pp. 22-27.
  
  * [3] A. Sarafianos, R. Llido, O. Gagliano, V. Serradeil, M. Lisart et al., "Building the electrical model of the pulsed photoelectric laser stimulation of an nmos transistor in 90nm technology," in 38th International Symposium for Testing and Failure Analysis, (ISTFA) 2012, 2012, pp. 5B–5.
