#!/bin/bash
# corrections from 04.04.24

 for i in 375; do
	echo "work with sample $i"
	cd ALYU-structure-$i
	mkdir forward revc-reverse
	
	cat ../list_of_IDs.txt | while read line; do
		cat ../list_of_size_classes.txt | while read size; do
			samtools view -F 16 ALYU-$i-exonintron_$line.sorted.bam | grep $size | grep 'NM:i:0' |  awk '{print $10}' > $line-$size-forward.txt
			samtools view -f 16 ALYU-$i-exonintron_$line.sorted.bam | grep $size | grep 'NM:i:0' |  awk '{print $10}' | tr ACGTacgt TGCAtgca | rev > $line-$size-revc-reverse.txt
			
			mkdir forward/$size revc-reverse/$size
			mv *-$size-forward.txt forward/$size/
			mv *-$size-revc-reverse.txt revc-reverse/$size/
			
		done
	done
	
	mkdir bams
	mv *.bam* bams/
	
	cd ../
done
