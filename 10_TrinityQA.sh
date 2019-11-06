#==================================================================================================
#   File: 10_TrinityQA.sh
#   Date: 11/03/19
#   Description: Perform QAQC procedures to evaluate qualtiy of de novo assembly
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal

mkdir $MRT/OUT/TrinityQA

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 2-0:00:00
#SBATCH --mem=128G
#SBATCH -J TrinityQA
#SBATCH -o '$MRT'/QSTAT/TrinityQA.o
#SBATCH --nodes=1-8
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=24

module purge
module load GCC/5.4.0-2.26
module load OpenMPI/1.10.3

module load SAMtools/0.1.19
module load Bowtie2/2.2.3

cp '$MRT'/OUT/transrate/cdhit.trinity/good.cdhit.trinity.fasta '$MRT'/OUT/TrinityQA

cd '$MRT'/OUT/TrinityQA

bowtie2-build ./good.cdhit.trinity.fasta final.trinity.fasta

cd '$MRT'/OUT

bowtie2 -p 24 -q --no-unal -k 20 -x ./TrinityQA/final.trinity.fasta -1 ./SILVA/all_R1.fastq -2 ./SILVA/all_R2.fastq \2>./TrinityQA/align_stats.txt | samtools view -@10 -Sb -o ./TrinityQA/bowtie2.bam 

cat 2>&1 ./TrinityQA/align_stats.txt

/opt/software/Trinity/2.6.6/util/TrinityStats.pl '$MRT'/OUT/TrinityQA/good.cdhit.trinity.fasta >&stats.log

scontrol show job ${SLURM_JOB_ID}' > trinityQA.sh

sbatch trinityQA.sh