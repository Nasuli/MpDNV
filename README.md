# MpDNV
This piepline is a part of analysis and visualization of sRNA reads mapping results for Myzus persicae densovirus (MpDNV).

In our experiment we did a sRNA sequencing of aphids (M. persicae). From sequenced libraries we selected sRNAs in size classes 15-34 nt and mapped them separately to coding and non-coding parts of the MpDNV genome (see the full list of genome parts in the **list_of_IDs.txt** file). Resulted bam file was splitted into separate files with more relevant size classes (from 21 to 23 and from 26 to 28 nts, see **list_of_size_classes.txt**) and with reads in forward and reverse orientation (see **for-rev-size-separator.sh** script). 

To visualize RNA logos for each MpDNV genome part, size class and strand I wrote **RNA_logo_maker.R** script. 
Here are some ezamples of resulted RNA logo pictures:
![pre_VP_as-27M-forward-bit](https://github.com/Nasuli/MpDNV/assets/39988388/0922d779-e7ef-4331-b3af-e6de8af59273)
![spliced_VP_s-27M-revc-reverse-bit](https://github.com/Nasuli/MpDNV/assets/39988388/6280e391-3720-44c5-8284-b527a60e032c)
