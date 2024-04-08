This set of two R scripts is made to calculate and visualize the number of sRNA reads (in different size classes) mapped to reference genomes. Both of them are used count table created by MISIS program.

The script **sRNA_size_classes.R** was created to calculate the number of sRNA reads (in different size classes) mapped to each reference genome (virusNames). As a result of this script you will get a nice bar plot represented the number of sRNA reads in 20-30 nt size classes in forward and reverse orientation:
![MpDNV_74c - Viral sRNA size profiles 20-30 nt  Sample 1](https://github.com/Nasuli/MpDNV/assets/39988388/cf4af5b7-7d0b-4ece-82c3-2dff958de41f)

The script **genome_coverage_visualization.R** was created to visualize the number of sRNA reads (in size ranges 20-30 nt, 20-24 nt, and 25-30 nt) mapped to each position on each reference genome (virusNames) in forward and reverse orientation. As a result of this script you will get maps representing the number of sRNAs (in selected size classes) coveredeach position of selected referene. The resulting picture looks like this:

![MpDNV_74c sRNA barplot - 20-30 size classes  Sample 3](https://github.com/Nasuli/MpDNV/assets/39988388/b0bc0e17-baaf-4728-ae19-1d8b26b5cef6)
