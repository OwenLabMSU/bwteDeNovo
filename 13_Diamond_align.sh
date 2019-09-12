#==================================================================================================
#   File: 13_Diamong_align.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Perform transcript alignments using Diamond
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
#SBATCH -t 7-0:00:00 
#SBATCH --mem=60G 
#SBATCH -J Diamond_align
#SBATCH -o /mnt/research/avian/teal/QSTAT/Diamond_align.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module purge
module load icc/2018.1.163-GCC-6.4.0-2.28  impi/2018.1.163
module load DIAMOND/0.9.22

cd '$SCR'/DB_Fasta

diamond blastx -b 7.0 -c 2 -e 0.00001 -k 5 --sensitive -d diamond.db -q Trinity.fasta.transdecoder.cds -o matches2.m8

scontrol show job ${SLURM_JOB_ID}' > Diamond_align.sh

sbatch Diamond_align.sh


