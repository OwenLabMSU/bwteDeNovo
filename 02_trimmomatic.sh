#==================================================================================================
#   File: 02_trimmomatic.sh
#   Date: 10/27/19
#   Description: Trim adapters and quality filter data using Trimmomatic
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

mkdir $SCR/OUT/Trimmomatic
mkdir $SCR/OUT/Trimmomatic/paired
mkdir $SCR/OUT/Trimmomatic/unpaired
mkdir $MRT/QSTAT/Trimmomatic
mkdir $MRT/SHELL/Trimmomatic

cd $MRT/SHELL

ls $MRT/RAW/PilotPool | grep -v "R2" | sed 's/_R1_001.fastq\.gz//g' | while read -r LINE
do

echo '#!/bin/sh 
#SBATCH -t 2:00:00
#SBATCH --mem-per-cpu=6G
#SBATCH -J Trimmomatic
#SBATCH -o '$MRT'/QSTAT/Trimmomatic/'$LINE'.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module purge
module load Trimmomatic/0.38-Java-1.8.0_162

cd '$MRT'/RAW/PilotPool

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.38.jar PE -threads 12 -phred33 '$LINE'_R1_001.fastq.gz '$LINE'_R2_001.fastq.gz '$LINE'_R1_paired.fastq.gz '$LINE'_R1_unpaired.fastq.gz '$LINE'_R2_paired.fastq.gz '$LINE'_R2_unpaired.fastq.gz ILLUMINACLIP:/opt/software/Trimmomatic/0.32/adapters/TruSeq3-PE-2.fa:2:30:10:1:true SLIDINGWINDOW:4:15 MINLEN:40

mv '$LINE'_R1_paired.fastq.gz '$LINE'_R2_paired.fastq.gz '$SCR'/OUT/Trimmomatic/paired/
mv '$LINE'_R1_unpaired.fastq.gz '$LINE'_R1_unpaired.fastq.gz '$SCR'/OUT/Trimmomatic/unpaired/ 

scontrol show job ${SLURM_JOB_ID}' > ./Trimmomatic/Trimmomatic."$LINE".sh

sbatch ./Trimmomatic/Trimmomatic."$LINE".sh

done