#==================================================================================================
#   File: 06_concat.sh
#   Date: 10/29/19
#   Description: Cat all reads together before performing de novo assembly
#	Run: Interactively - array
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 2:00:00
#SBATCH --mem=24G
#SBATCH -J concat
#SBATCH -o '$MRT'/QSTAT/concat.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4

cd '$MRT'/OUT/SILVA

gunzip ./*.gz

cat ./*.fq.1 > all_R1.fastq
cat ./*.fq.2 > all_R2.fastq

scontrol show job ${SLURM_JOB_ID}' > concat.sh

sbatch concat.sh