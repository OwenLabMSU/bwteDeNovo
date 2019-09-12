#==================================================================================================
#   File: 06_Trinity.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Run TRINITY to perform de novo assembly
#	Run: Interactively - array
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
#SBATCH -t 4-0:00:00
#SBATCH --mem=250G
#SBATCH -J Trinity
#SBATCH -o /mnt/research/avian/teal/QSTAT/Trinity.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

module purge
module load icc/2017.4.196-GCC-6.4.0-2.28 impi/2017.3.196 Trinity/2.6.6

Trinity --seqType fq --SS_lib_type RF --max_memory 225G --CPU 8 --min_contig_length 200 --left /mnt/research/avian/teal/OUT/Trinity/all_R1.fastq --right /mnt/research/avian/teal/OUT/Trinity/all_R2.fastq --output /mnt/scratch/dolinsk5/avian/teal/Trinity/Trinity_BWTE_de_novo_April52019

scontrol show job ${SLURM_JOB_ID}' > trinity.sh

sbatch trinity.sh


