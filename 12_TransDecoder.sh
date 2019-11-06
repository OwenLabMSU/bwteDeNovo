#==================================================================================================
#   File: 12_TransDecoder.sh
#   Date: 11/03/19
#   Description: Use TransDecoder to predict open reading frames
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 2-0:00:00 
#SBATCH --mem=64G 
#SBATCH -J TransDecoder
#SBATCH -o '$MRT'/QSTAT/TransDecoder.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module purge
module load icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132
module load TransDecoder/2.1.0-Perl-5.24.1

cd '$MRT'/OUT

TransDecoder.LongOrfs -t ./transrate/cdhit.trinity/good.cdhit.trinity.fasta
TransDecoder.Predict -t ./transrate/cdhit.trinity/good.cdhit.trinity.fasta --cpu 12

scontrol show job ${SLURM_JOB_ID}' > TransDecoder.sh

sbatch TransDecoder.sh


