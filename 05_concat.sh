#==================================================================================================
#   File: 05_concat.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Cat all reads together before performing de novo assembly
#	Run: Interactively - array
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/research/avian/teal/OUT/rrnaFiltered
#==================================================================================================

MRT=/mnt/research/avian/teal
SCR=/mnt/scratch/dolinsk5/avian/teal

cd $MRT/SHELL


echo '#!/bin/sh 
#SBATCH -C [intel16|intel18]
#SBATCH -N 1 -c 9
#SBATCH -t 4:00:00
#SBATCH --mem 16G
#SBATCH -J CatReads
#SBATCH -o /mnt/research/avian/teal/QSTAT/CatReads.o

cd /mnt/research/avian/teal/OUT/rrnaFiltered

gunzip ./*.gz

cat ./*.fq.1 > all_R1.fastq
cat ./*.fq.2 > all_R2.fastq


scontrol show job ${SLURM_JOB_ID}' > CatReads.sh

sbatch CatReads.sh


