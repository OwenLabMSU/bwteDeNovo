#==================================================================================================
#   File: 1_initialFastQC.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Run FastQC to examine reads
#	Run: Interactively - array
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/research/avian/teal/OUT/FastQC2/<ID>.html
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/scratch/dolinsk5/avian/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -C intel16|intel18
#SBATCH -N 1 -c 9
#SBATCH -t 8:00:00
#SBATCH --mem 16G 
#SBATCH -J FastQC_array
#SBATCH --mail-user dolinsk5@msu.edu
#SBATCH -o '$MRT'/QSTAT/FastQC/FastQC_array.o

module load FastQC/0.11.7-Java-1.8.0_162

cd '$MRT'/RAW

fastqc ./*.fastq.gz

scontrol show job ${SLURM_JOB_ID}' > fastqcraw.sh

sbatch fastqcraw.sh -t 0-92
 

