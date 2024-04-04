# MpDNV
This piepline is part of the analysis and visualization of sRNA reads mapping results for Myzus persicae densovirus (MpDNV).

In our experiment, we conducted sRNA sequencing of aphids (M. persicae). From the sequenced libraries we selected sRNAs in size classes 15-34 nt and mapped them separately to the coding and non-coding parts of the MpDNV genome (refer to the full list of genome parts in the **list_of_IDs.txt** file). The resulting BAM file was split into separate files with more relevant size classes (ranging from 21 to 23 and from 26 to 28 nts, see **list_of_size_classes.txt**) and with reads in forward and reverse orientations (refer to the **for-rev-size-separator.sh** script). 

To visualize RNA logos for each MpDNV genome part, size class, and strand, I created the **RNA_logo_maker.R** script. 
Here are some examples of the resulting RNA logo pictures:
![pre_VP_as-27M-forward-bit](https://github.com/Nasuli/MpDNV/assets/39988388/0922d779-e7ef-4331-b3af-e6de8af59273)
![pre_VP_as-26M-revc-reverse-bit](https://github.com/Nasuli/MpDNV/assets/39988388/52a90e18-3b36-4e69-9b39-76317e4f44f6)
