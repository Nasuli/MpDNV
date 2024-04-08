############################################################################
#                            / RNA-logo maker /                            #
#                   This script was created to calculate                   #
#     the number of sRNA reads for selected size classes (SizeClasses),    #
#       for different parts of the MpDNV viral genome (GenomeParts),       #
#         on forward and reverse orientations (ReadsOrientation).          #
#  At the experiment we had 8 sRNA libraries (from ALYU-368 to ALYU-375).  #
############################################################################

setwd("~/Main_folder/ROME_proj/Results_for_structure")
#install.packages (c("ggseqlogo", "ggplot2"))

library(ggseqlogo)
library(ggplot2)

SampleNumbers = c(368:375)
SizeClasses = c('21M', '22M', '23M', '26M', '27M', '28M')

GenomeParts = c("5Non-mRNA", "pre-NS_long", "spliced-NS_long", "pre-NS_short", "spliced-NS_short", 
               "intron_NS", "pre_VP_as", "spliced_VP_as", 
               "intron1_VP_as", "intron2_VP_as", 
               "pre_VP_s", "spliced_VP_s", "intron1_VP_s", "intron2_VP_s", "3Non-mRNA")
ReadsOrientation = c('forward', 'revc-reverse')

main_path <- "~/Main_folder/ROME_proj/Results_for_structure" # the path to folder where folders with samples are stored (usually the same as working directory)

output_log_file <- "~/Main_folder/ROME_proj/Results_for_structure/ALYU-RNA_logo_creation.log"
sink(output_log_file, append = T, split=T) # to make a log file with the number of reads for each combination SampleNumber/SizeClasses/GenomeParts/ReadsOrientation
# sink arguments:"append" - add new info, not overwrite the file; "split" - show info messages on the console and write them into the file at the same time

for (SampNum in SampleNumbers) {
  print (SampNum)
  for (ori in ReadsOrientation) {
    for (size in SizeClasses) {
      print (c(size, ori))
      SampName <- paste('ALYU-structure-', SampNum, '/', ori, '/', size, sep = "")
      sample_path <- file.path(main_path, SampName)
      setwd(sample_path)
      for (IDs in GenomeParts) {
        print (IDs)
  
        file_name <- (paste(IDs, '-', size, '-', ori, '.txt', sep = ""))
        file_for_logo <- gsub("T", "U", scan(file_name, what="", sep="\t"))
      
        if (length(file_for_logo) <= 5) {
          cat("Error:", file_name, "has less than 5 reads. Skip the file", "\n")
        } else {
        print (length(file_for_logo))
        bit <-ggplot() + geom_logo(file_for_logo, method = "bits", font = 'helvetica_bold' ) + theme_logo() + 
          ggtitle(label = (paste(IDs, '-', size, '-', ori, sep = ""))) + theme(plot.title = element_text(hjust = 0.5))
        prob <-ggplot() + geom_logo(file_for_logo, method = "probability", font = 'helvetica_bold') + theme_logo()+ 
          ggtitle(label = (paste(IDs, '-', size, '-', ori, sep = ""))) + theme(plot.title = element_text(hjust = 0.5))
      
        file_name_for_saving_bit <- (paste(IDs, '-', size, '-', ori, '-bit.png', sep = ""))
        file_name_for_saving_prob <- (paste(IDs, '-', size, '-', ori, '-prob.png', sep = ""))
      
        ggsave(file_name_for_saving_bit, bit,png, width = 12, height = 4)
        ggsave(file_name_for_saving_prob, prob,png, width = 12, height = 4)
      
        } # zero file checking   
      } # end for GenomeParts cycle
    } # end for SizeClasses cycle
  } # end for ReadsOrientation cycle
}
sink() ## stop writing log into the file
