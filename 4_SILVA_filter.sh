#==================================================================================================
#   File: 4_SILVA_filter.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Perform filtering of rRNAs based on SILVA database
#	Run: Interactively - array
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/research/avian/teal/OUT/FastQC2/<ID>.html
#==================================================================================================

MRT=/mnt/research/avian/teal
SCR=/mnt/scratch/dolinsk5/avian/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -C [intel16|intel18]
#SBATCH -N 1 -c 9
#SBATCH -t 8:00:00
#SBATCH --mem 100G
#SBATCH -J IndexSilva
#SBATCH -o /mnt/research/avian/teal/QSTAT/IndexSilva.o

module load GCC/5.4.0-2.26
module load OpenMPI/1.10.3

module load SAMtools/0.1.19
module load Bowtie2/2.2.3

cd /mnt/research/avian/teal

cat SILVA_132_LSUParc_tax_silva.fasta SILVA_132_SSURef_Nr99_tax_silva.fasta > SILVA_DBs.fasta

bowtie2-build SILVA_DBs.fasta SILVA_DBs

scontrol show job ${SLURM_JOB_ID}' > indexsilva.sh

sbatch indexsilva.sh


