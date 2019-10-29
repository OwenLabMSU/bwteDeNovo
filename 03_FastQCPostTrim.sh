#==================================================================================================
#   File: 3_FastQCPostTrim.sh
#   Date: 10/28/19
#   Description: Run FastQC to check that adapter sequences are gone
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 3:00:00
#SBATCH --mem=32G
#SBATCH -J PostTrimFastQC
#SBATCH -o /mnt/research/avian/teal/QSTAT/PostTrimFastQC.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module load FastQC/0.11.7-Java-1.8.0_162

cd '$SCR'/OUT/Trimmomatic/paired

mkdir '$MRT'/OUT/FastQC/PostTrim

fastqc ./*.fastq.gz -o '$MRT'/OUT/FastQC/PostTrim' > FastQCPostTrim.sh

sbatch FastQCPostTrim.sh