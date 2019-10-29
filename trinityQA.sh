#!/bin/sh 
#SBATCH -t 7-0:00:00
#SBATCH --mem=16G
#SBATCH -J TrinityQA
#SBATCH -o /mnt/research/avian/teal/QSTAT/TrinityQA.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

module purge
module load GCC/5.4.0-2.26
module load OpenMPI/1.10.3

module load SAMtools/0.1.19
module load Bowtie2/2.2.3

cd /mnt/scratch/dolinsk5/avian/teal/Trinity

bowtie2-build ./Trinity.fasta Trinity.fasta

bowtie2 -p 8 -q --no-unal -k 20 -x Trinity.fasta -1 all_R1.fastq -2 all_R2.fastq \2>align_stats.txt| samtools view -@10 -Sb -o bowtie2.bam 

cat 2>&1 align_stats.txt

scontrol show job ${SLURM_JOB_ID}
