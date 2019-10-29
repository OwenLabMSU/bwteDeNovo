#==================================================================================================
#   File: 04_SILVABuildDBs.sh
#   Date: 10/28/19
#   Description: Create and index SILVA database of rRNAs for downstream filtering
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 6:00:00
#SBATCH --mem=32G
#SBATCH -J SILVABuildDBs
#SBATCH -o '$MRT'/QSTAT/SILVABuildDBs.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module load GCC/5.4.0-2.26 OpenMPI/1.10.3
module load SAMtools/0.1.19 Bowtie2/2.2.3

mkdir '$MRT'/OUT/SILVA
cd '$MRT'/RAW/SILVA

cat SILVA_132*.fasta > SILVA_DB.fasta

cat SILVA_DB.fasta | tr U T >> SILVA_DB_Translated.fasta

bowtie2-build SILVA_DB_Translated.fasta SILVA_DB

mv SILVA_DB.* '$MRT'/OUT/SILVA

scontrol show job ${SLURM_JOB_ID}' > SILVABuildDBs.sh

sbatch SILVABuildDBs.sh


