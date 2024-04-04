# MpDNV
This piepline is a part of analysis and visualization of sRNA reads mapping results for Myzus persicae densovirus (MpDNV).
In our experiment we did sRNA sequencing of aphids (M. persicae). From sequenced libraries we selected sRNAs in size classes 15-34 nt and mapped them to coding and non-coding parts of the MpDNV genome (see the full list of genome parts in the **list_of_IDs.txt** file). Resulted bam file was splitted into separate files with more relevant size classes (from 21 to 23 and from 26 to 28 nts) and with reads in forward and reverse orientation (see **for-rev-size-separator.sh** script). 
To visualize RNA logos for each MpDNV genome part, size class and strand I wrote **RNA_logo_maker.R** script. 
Here are some ezamples of resulted RNA logo pictures:
