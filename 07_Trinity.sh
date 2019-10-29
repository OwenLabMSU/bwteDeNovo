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
module load icc/2017.4.196-GCC-6.4.0-2.28 impi/2017.3.196 Trinity/2.6.6

Trinity --seqType fq \
    --SS_lib_type FR \
    --max_memory 225G \
    --CPU 16 \
    --min_contig_length 200 \
    --left '$MRT'/OUT/Trinity/all_R1.fastq \
    --right '$MRT'/OUT/Trinity/all_R2.fastq \
    --output '$MRT'/Trinity/Trinity_BWTE_Oct292019

scontrol show job ${SLURM_JOB_ID}' > trinity.sh

sbatch trinity.sh

