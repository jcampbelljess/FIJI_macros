# FIJI_macros
macros and files created by JL Campbell, 2021 
for use with ImageJ https://imagej.nih.gov/ij/download.html and FIJI https://imagej.net/software/fiji/downloads;


These files were created by Jessica L. Campbell (2021) for a validation test of the Total Difference method first introduced by Cox et al. 2009.  The accompanying publication is open source:  Campbell, J.L.; Butaric, L.N. Technical Modifications for the Application of the Total Difference Method for Frontal Sinus Comparison. Biology 2022, 11, 1075. https:// doi.org/10.3390/biology11071075

The original method was created to be an easier way to quantitively access the outlines of the frontal sinus for individuality for use in 
personal identification of unidentified skeletal remains, when antemortem radiographs were available for comparison.  It is for 1:1 comparisons, and is not an optimal method for arrays.

The Total Difference method requires an existing outline, created as described by Christensen 2004.
An origin is identified as the intersection of the facial midline landmarks with a transverse line extended between the supraorbital margins (the outline's baseline).
The baseline and right baseline lengths are recorded in increase repeatability of the method.
A line from the origin to the sinus outline, with a 3° slope is then drawn and the length recorded.
Lines are drawn at every 3° through to 177°, resulting in 59 length measurements.  
The 0° and 180° are excluded (these are the baseline measurements).

For a comparison between antemortem and a postmortem image, the differences at each line are calculated and summed, and an Odds Ratio applied using a predetermined frequency distribution.  
Further commentary on the identification portion of the original publication is not included here since this macro only involves the technique.


