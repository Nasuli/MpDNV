############################################################################
#                     / counting the number of sRNAs /                     #
#                   This script was created to calculate                   #
#            the number of sRNA reads in different size classes            #
#                   mapped to several viruses (virusNames).                #
#                                                                          #
#               At the experiment we had 12 sRNA libraries,                #
#   but this example creates images only for two of them (sampleNumbers).  #
#                                                                          #
#              As the base for visualization this script use               #
#         SAMP_table_pm_15_34.txt table created by MISIS program.          #
#                                                                          #
############################################################################

#install.packages (c("tidyr", "dplyr", "ggplot2", "tidyverse"))

library(tidyr)
library(dplyr)
library(ggplot2)
library(tidyverse)

setwd("~/MpDNV/RNA_size_classes")
main_path <- "~/MpDNV/RNA_size_classes/MISIS_results"

virusNames <- c('MpDNV_74c', 'MpFLV_c', 'TuYV') # Set of viral reference names
SampleNumbers <- c(1:2) # set of sRNA datasets 

for (virus in virusNames) {  # Choose virus for visualization
  print (virus)
  for (SampNum in SampleNumbers) {  # Choose sample for visualization
      print (SampNum)
      
    # Set folder for Virus/Sample pair
    sample_path <- paste(main_path, '/', virus, '/', SampNum, sep = "") 
    setwd(sample_path)
    
    # Upload data table
    sRNA_name <- (paste(virus, '_table_pm_15_34.txt', sep = ""))
    df_sRNA_main <-read.csv(sRNA_name, sep = '\t', stringsAsFactors = FALSE, header = T) 
    colnames(df_sRNA_main) <- c("position",	"for_15nt",	"for_16nt",	"for_17nt",	"for_18nt",	"for_19nt", 
                           "for_20nt",	"for_21nt",	"for_22nt",	"for_23nt",	"for_24nt", "for_25nt", 
                           "for_26nt",	"for_27nt",	"for_28nt",	"for_29nt",	"for_30nt", 
                           "for_31nt", "for_32nt", "for_33nt", "for_34nt", 
                           "rev_15nt",	"rev_16nt",	"rev_17nt",	"rev_18nt",	"rev_19nt", 
                           "rev_20nt",	"rev_21nt",	"rev_22nt",	"rev_23nt",	"rev_24nt", "rev_25nt", 
                           "rev_26nt",	"rev_27nt",	"rev_28nt",	"rev_29nt",	"rev_30nt", 
                           "rev_31nt", "rev_32nt", "rev_33nt", "rev_34nt", 
                           "fwd_total", "rev_total", "total")
  
    
    # Create MISIS-like bargraph to show genome coverage of each virus by sRNAs in all size-slasses (15-34 nt)
    # by sRNAs in all size-slasses (15-34 nt), and in two size-ranges (20-24 nt and 25-30 nt)
    df1_sRNA_total <- df_sRNA_main %>% select(position, fwd_total, rev_total) %>% # Transform sRNA table. Add "-" to all values on minus strand
      mutate(rev_total = -rev_total) %>% 
      gather(strand, num_of_reads, 2:3)
    
    sRNA_bars_total <- data.frame(colSums(df_sRNA_main[, c("for_20nt",	"for_21nt",	"for_22nt",	"for_23nt",	"for_24nt", "for_25nt", 
                                                "for_26nt",	"for_27nt",	"for_28nt",	"for_29nt",	"for_30nt",
                                                "rev_20nt",	"rev_21nt",	"rev_22nt",	"rev_23nt",	"rev_24nt", "rev_25nt", 
                                                "rev_26nt",	"rev_27nt",	"rev_28nt",	"rev_29nt",	"rev_30nt")]) *
      c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1)) %>%       # summaries all reads for each size class, for reverse reads makes final sum negative
      rownames_to_column('id')%>%      # convert rownames into column 'id'
      separate(id, c("Direction", "size")) %>%    # separate id (for_20nt) column into Direction (for) and size (20nt)
      mutate(size = as.numeric(gsub("\\D", "", size))) %>% 
      rename(value = 3)%>%    # rename 3rd column into 'value'
      add_column(sample='all_reads_pm') 
    
    sRNA_bars_title <- paste(virus, '- Viral sRNA size profiles 20-30 nt. Sample', SampNum, sep = " ") 
    sRNA_barplot <- sRNA_bars_total  %>% 
    ggplot(aes(x = factor(sample), y = value, group = size, fill = size)) +
      geom_bar(stat = "identity", position = position_dodge(0.9))  + 
      labs(x = "size classes", y = "number of reads") + 
      ggtitle(sRNA_bars_title) + 
      theme(plot.title = element_text(hjust = 0.5),axis.text.x=element_blank(),axis.ticks.x=element_blank())+
      geom_text(aes(y = value + 1000 * sign(value),
                    label=if_else(value == 0, NA_character_, paste0(abs(value)))), 
                position=position_dodge(width=0.9)) + 
      theme(panel.background = element_rect(fill = "white"))+ 
      geom_hline(yintercept = 0, color = 'black')  +
      scale_fill_gradient(low = "#ff6e6e", high = "#950000", name = "Size class",
                          breaks = c(20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30),
                          labels=c("20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30")) 

    
    ggsave(paste(sRNA_bars_title, '.png', sep = ""), sRNA_barplot,png, width = 15)
    
  } # end for SampleNumbers loop
} # end for virusNames loop
