#==================================================================================================
#   File: 01_initialFastQC.sh
#   Date: 10/27/19
#   Description: Run FastQC to examine raw reads
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 1:00:00
#SBATCH --mem=32G
#SBATCH -J initialFastQC
#SBATCH -o /mnt/research/avian/teal/QSTAT/InitialFastQC.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module load FastQC/0.11.7-Java-1.8.0_162

cd '$MRT'/RAW/PilotPool

mkdir '$MRT'/OUT/FastQC/
mkdir '$MRT'/OUT/FastQC/Initial

fastqc ./*.fastq.gz -o '$MRT'/OUT/FastQC/Initial

scontrol show job ${SLURM_JOB_ID}' > 01_initialFastQC.sh

sbatch 01_initialFastQC.sh
 

