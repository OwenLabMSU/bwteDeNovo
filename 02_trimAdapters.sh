#==================================================================================================
#   File: 2_trimAdapters.sh
#	Directory code:	/mnt/research/avian/mallard/CODE
#   Date: 03/21/19
#   Description: Trimmomatic adapter trimming, assume Truseq3 adapters 
#	Run: Interactively
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/scratch/dolinsk5/avian/teal/OUT/Trimmomatic/paired
#		/mnt/scratch/dolinsk5/avian/teal/OUT/Trimmomatic/single
#		/mnt/research/avian/teal/OUT/Trimmomatic/paired
#		/mnt/research/avian/teal/OUT/Trimmomatic/single
#==================================================================================================

MRT=/mnt/research/avian/teal
SCR=/mnt/scratch/dolinsk5/avian/teal

cd $MRT/SHELL
ls $MRT/RAW/*fastq.gz > trim_adapter_fastq.txt
f1_R1=(`cat trim_adapter_fastq.txt | grep R1`)
f1_R2=(`cat trim_adapter_fastq.txt | grep R2`)
f3=(`cat trim_adapter_fastq.txt | cut -f7 -d/ | cut -f2,3 -d_ | uniq`)

for((i=0; i<${#f3[@]}; i++)) do
echo '#!/bin/sh 
#SBATCH -C intel16|intel18
#SBATCH -N 1 -c 9
#SBATCH -t 8:00:00
#SBATCH --mem 16G 
#SBATCH -J Trim_Adap

cd '$MRT'/RAW/
module load Trimmomatic/0.38-Java-1.8.0_162

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.38.jar PE -threads 8 -phred33 -trimlog log_'${f3[$i]}' '${f1_R1[$i]}' '${f1_R2[$i]}' '${f3[$i]}'_R1_pe.fastq.gz '${f3[$i]}'_R1_se.fastq.gz '${f3[$i]}'_R2_pe.fastq.gz '${f3[$i]}'_R2_se.fastq.gz ILLUMINACLIP:/opt/software/Trimmomatic/0.32/adapters/TruSeq3-PE-2.fa:2:30:10:1:true SLIDINGWINDOW:4:15 MINLEN:40

cp '${f3[$i]}'_R1_pe.fastq.gz '${f3[$i]}'_R2_pe.fastq.gz '$MRT'/OUT/Trimmomatic/paired/
cp '${f3[$i]}'_R1_se.fastq.gz '${f3[$i]}'_R2_se.fastq.gz '$MRT'/OUT/Trimmomatic/single/

mv '${f3[$i]}'_R1_pe.fastq.gz '${f3[$i]}'_R2_pe.fastq.gz '$SCR'/OUT/Trimmomatic/paired/
mv '${f3[$i]}'_R1_se.fastq.gz '${f3[$i]}'_R2_se.fastq.gz '$SCR'/OUT/Trimmomatic/single/


scontrol show job ${SLURM_JOB_ID}' > TrimAdap.sh

sbatch -o "/mnt/research/avian/teal/QSTAT/Trimmomatic/Trim_Adap_${f3[$i]}.o" TrimAdap.sh

done

#took 75 minutes
