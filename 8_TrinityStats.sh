#==================================================================================================
#   File: 8_TrinityStats.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Calculate summary statistics for de novo assembly
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
#SBATCH -C [intel16|intel18]
#SBATCH -N 1 -c 9
#SBATCH -t 8:00:00
#SBATCH --mem=16G
#SBATCH -J TrinityStats
#SBATCH -o /mnt/research/avian/teal/QSTAT/TrinityStats.o

module purge
module load icc/2017.4.196-GCC-6.4.0-2.28 impi/2017.3.196 Trinity/2.6.6

cd '$SCR'/Trinity

/opt/software/Trinity/2.6.6/util/TrinityStats.pl '$SCR'/Trinity/Trinity_BWTE_de_novo_April52019/Trinity.fasta >&stats.log

scontrol show job ${SLURM_JOB_ID}' > trinitystats.sh

sbatch trinitystats.sh
