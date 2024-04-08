############################################################################
#              / visualization of genome coverage by sRNAs /               #
#           This script was created to visualize genome coverage           #
#                    of several viruses (virusNames)                       #
#    in different ranges of size classes (20-30 nt, 20-24 nt, 25-30 nt).   #
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
main_path <- "~/MpDNV/RNA_size_classes/MISIS_results" # the path to folder where folders with samples are stored 

virusNames <- c('MpDNV_74c', 'MpFLV_c', 'TuYV') # Set of viral reference names
sampleNumbers <- c(1:2) # set of sRNA datasets 

for (virus in virusNames) {  # Choose virus for visualization
  print (virus)
  for (SampNum in sampleNumbers) {  # Choose sample for visualization
      print (SampNum)
      
    # Set folder for Virus/Sample pair
    sample_path <- paste(main_path, '/', virus, '/', SampNum, sep = "") 
    setwd(sample_path)
    
    # Upload data table
    sRNA_name <- (paste(virus, '_table_pm_15_34.txt', sep = "")) # the piepline is based on one table $SampleName_table_pm_15_34.txt created by the MISIS program
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
  
    
    # Create MISIS-like bargraph to show genome coverage of each virus 
    # in a broad range of size-slasses (20-30 nt), and in two important size-ranges (20-24 nt and 25-30 nt)
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
    
    # Create MISIS-like bargraph to show genome coverage of each virus by sRNAs in 3 size-ranges (20-30 nt, 20-24 nt and 25-30 nt)
    df_sRNA_main$fwd_20_30 <- rowSums(df_sRNA_main[, c("for_20nt",	"for_21nt",	"for_22nt",	"for_23nt",	"for_24nt",
                                                       "for_25nt", "for_26nt",	"for_27nt",	"for_28nt",	"for_29nt",	"for_30nt")])
    df_sRNA_main$rev_20_30 <- -rowSums(df_sRNA_main[, c("rev_20nt",	"rev_21nt",	"rev_22nt",	"rev_23nt",	"rev_24nt",
                                                        "rev_25nt", "rev_26nt",	"rev_27nt",	"rev_28nt",	"rev_29nt",	"rev_30nt")])
    df1_sRNA_20_30 <- df_sRNA_main %>% select(position, fwd_20_30, rev_20_30) %>%
      gather(strand, num_of_reads, 2:3) 
    
    df_sRNA_main$fwd_20_24 <- rowSums(df_sRNA_main[, c("for_20nt",	"for_21nt",	"for_22nt",	"for_23nt",	"for_24nt")])
    df_sRNA_main$rev_20_24 <- -rowSums(df_sRNA_main[, c("rev_20nt",	"rev_21nt",	"rev_22nt",	"rev_23nt",	"rev_24nt")])
    df1_sRNA_20_24 <- df_sRNA_main %>% select(position, fwd_20_24, rev_20_24) %>%
      gather(strand, num_of_reads, 2:3) 
    
    df_sRNA_main$fwd_25_30 <- rowSums(df_sRNA_main[, c("for_25nt", "for_26nt",	"for_27nt",	"for_28nt",	"for_29nt",	"for_30nt")])
    df_sRNA_main$rev_25_30 <- -rowSums(df_sRNA_main[, c("rev_25nt", "rev_26nt",	"rev_27nt",	"rev_28nt",	"rev_29nt",	"rev_30nt")])
    df1_sRNA_25_30 <- df_sRNA_main %>% select(position, fwd_25_30, rev_25_30) %>%
      gather(strand, num_of_reads, 2:3) 
    
   
    sRNA_plot_20_30_title <- paste(virus, 'sRNA barplot - 20-30 size classes. Sample', SampNum, sep = " ") 
    sRNA_plot_20_30 <- ggplot(data=df1_sRNA_20_30, aes(x=position, y=num_of_reads, colour = strand, fill = strand)) +
      geom_bar(stat="identity", show.legend = T) +
      scale_color_manual(values = c("red", "blue"))+
      scale_fill_manual(values = c("red", "blue"))+
      ggtitle(label = sRNA_plot_20_30_title)+ 
      theme(plot.title = element_text(hjust = 0.5))+ 
      theme(panel.background = element_rect(fill = "white"))+
      geom_vline(xintercept = 0, color = 'grey') +
      # theme(axis.text.y = element_text(size = 15)) +  #   Make numbers on Y-axis bigger
      labs(x = "genome position", y = "number of mapped reads") 
   
    sRNA_plot_20_24_title <- paste(virus, 'sRNA barplot - 20-24 size classes. Sample', SampNum, sep = " ") 
    sRNA_plot_20_24 <- ggplot(data=df1_sRNA_20_24, aes(x=position, y=num_of_reads, colour = strand, fill = strand)) +
      geom_bar(stat="identity", show.legend = T) +
      scale_color_manual(values = c("red", "blue"))+
      scale_fill_manual(values = c("red", "blue"))+
      ggtitle(label = sRNA_plot_20_24_title)+ 
      theme(plot.title = element_text(hjust = 0.5))+ 
      theme(panel.background = element_rect(fill = "white"))+
      geom_vline(xintercept = 0, color = 'grey') +
      # theme(axis.text.y = element_text(size = 15)) +  #   Make numbers on Y-axis bigger
      labs(x = "genome position", y = "number of mapped reads") 
    
    sRNA_plot_25_30_title <- paste(virus, 'sRNA barplot - 25-30 size classes. Sample', SampNum, sep = " ") 
    sRNA_plot_25_30 <- ggplot(data=df1_sRNA_25_30, aes(x=position, y=num_of_reads, colour = strand, fill = strand)) +
      geom_bar(stat="identity", show.legend = T) +
      scale_color_manual(values = c("red", "blue"))+
      scale_fill_manual(values = c("red", "blue"))+
      ggtitle(label = sRNA_plot_25_30_title)+ 
      theme(plot.title = element_text(hjust = 0.5))+ 
      theme(panel.background = element_rect(fill = "white"))+
      geom_vline(xintercept = 0, color = 'grey') +
      # theme(axis.text.y = element_text(size = 15)) +  #   Make numbers on Y-axis bigger
      labs(x = "genome position", y = "number of mapped reads") 
    
    # Save all created barplots
    
    ggsave(paste(sRNA_plot_20_30_title, '.png', sep = ""), sRNA_plot_20_30, png, width = 15)
    ggsave(paste(sRNA_plot_20_24_title, '.png', sep = ""), sRNA_plot_20_24, png, width = 15)
    ggsave(paste(sRNA_plot_25_30_title, '.png', sep = ""), sRNA_plot_25_30, png, width = 15)
    
  } # end for sampleNumbers loop
} # end for viral loop
