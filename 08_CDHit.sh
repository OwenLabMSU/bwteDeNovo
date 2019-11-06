#==================================================================================================
#   File: 08_CDHit.sh
#   Date: 10/29/19
#   Description: Use CD-Hit-Est to remove redundant transcripts
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal

mkdir $MRT/OUT/CDHIT

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 6:00:00
#SBATCH --mem=64G
#SBATCH -J cdhit
#SBATCH -o '$MRT'/QSTAT/cdhit.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module purge
module load icc/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132
module load CD-HIT/4.6.8

mv '$MRT'/Trinity '$MRT'/OUT

cd '$MRT'/OUT

cd-hit-est -i ./Trinity/Trinity_BWTE_Oct292019/Trinity.fasta -o ./CDHIT/cdhit.trinity.fasta -c 0.98 -M 63000 -T 12 -p 1 -d 0 -b 3

scontrol show job ${SLURM_JOB_ID}' > cdhit.sh

sbatch cdhit.sh
