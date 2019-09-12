#==================================================================================================
#   File: 11_TransDecoder.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Use TransDecoder to predict open reading frames
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
#SBATCH --mem=20G 
#SBATCH -J TransD
#SBATCH -o /mnt/research/avian/teal/QSTAT/TransD.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5

module purge
module load icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132
module load TransDecoder/2.1.0-Perl-5.24.1

TransDecoder.LongOrfs -t /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta
TransDecoder.Predict -t /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta

scontrol show job ${SLURM_JOB_ID}' > TransD.sh

sbatch TransD.sh


