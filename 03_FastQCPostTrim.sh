#==================================================================================================
#   File: 3_FastQCPostTrim.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Run FastQC to check that adapter sequences are gone
#	Run: Interactively - array
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/research/avian/teal/OUT/FastQC2/<ID>.html
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/scratch/dolinsk5/avian/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -C intel16|intel18
#SBATCH -N 1 -c 9
#SBATCH -t 8:00:00
#SBATCH --mem 100G 
#SBATCH -J FastQC_array
#SBATCH -o '$MRT'/QSTAT/FastQCfilt/FastQC_array.o

module load FastQC/0.11.7-Java-1.8.0_162

cd '$MRT'/OUT/rrnaFiltered

fastqc ./*.gz

mv ./*.zip '$MRT'/OUT/FastQCfilt/
mv ./*.html '$MRT'/OUT/FastQCfilt/

scontrol show job ${SLURM_JOB_ID}' > fastqcfilt.sh

sbatch fastqcfilt.sh -t 0-92