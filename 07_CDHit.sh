#==================================================================================================
#   File: 07_CDHit.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 10/27/19
#   Description: Use CD-Hit-Est to remove redundant transcripts
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/research/avian/teal/OUT/Trinity
#==================================================================================================

MRT=/mnt/research/avian/teal
SCR=/mnt/scratch/dolinsk5/avian/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 6:00:00
#SBATCH --mem=64G
#SBATCH -J cdhit
#SBATCH -o /mnt/home/homolaj1/Software/QSTAT/cdhit.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

cd /mnt/home/homolaj1/Software/cdhit

./cd-hit-est -i Trinity.fasta -o ./out/cdhit.trinity.fasta -c 0.98 -M 63000 -T 12 -p 1 -d 0 -b 3

scontrol show job ${SLURM_JOB_ID}' > cdhit.sh

sbatch cdhit.sh
