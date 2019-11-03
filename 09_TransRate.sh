#==================================================================================================
#   File: 09_TransRate.sh
#   Date: 10/29/19
#   Description: Use TransRate to evaluate the transcriptome assembly
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

mkdir $MRT/OUT/transrate

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 2-0:00:00
#SBATCH --mem=128G
#SBATCH -J TransRate
#SBATCH -o '$MRT'/QSTAT/transrate.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=24

module purge
module load Transrate/1.0.3

cd '$MRT'/OUT

transrate --assembly ./CDHIT/cdhit.trinity.fasta \
    --left ./SILVA/all_R1.fastq \
    --right ./SILVA/all_R2.fastq \
    --threads 24 \
    --output ./transrate

scontrol show job ${SLURM_JOB_ID}' > transrate.sh

sbatch transrate.sh
