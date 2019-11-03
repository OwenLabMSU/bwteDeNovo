#==================================================================================================
#   File: 07_Trinity.sh
#   Date: 10/29/19
#   Description: Run TRINITY to perform de novo assembly
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

mkdir $MRT/OUT/Trinity

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 4-0:00:00
#SBATCH --mem=250G
#SBATCH -J Trinity
#SBATCH -o '$MRT'/QSTAT/Trinity.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16

module purge
module load GCC/7.3.0-2.30 OpenMPI/3.1.1 Trinity/2.8.5

Trinity --seqType fq \
    --SS_lib_type FR \
    --max_memory 250G \
    --CPU 16 \
    --min_contig_length 200 \
    --left '$MRT'/OUT/SILVA/all_R1.fastq \
    --right '$MRT'/OUT/SILVA/all_R2.fastq \
    --output '$MRT'/Trinity/Trinity_BWTE_Oct292019

scontrol show job ${SLURM_JOB_ID}' > trinity.sh

sbatch trinity.sh