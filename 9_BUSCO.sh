#==================================================================================================
#   File: 9_BUSCO.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 03/26/19
#   Description: Run BUSCO to estimate completeness of transcriptome assembly
#	Run: Interactively - array
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/research/avian/teal/OUT/MyBusco
#==================================================================================================

MRT=/mnt/research/avian/teal
SCR=/mnt/scratch/dolinsk5/avian/teal

wget cegg.unige.ch/pub/SIBCOURSE/BUSCO-datasets.tar.gz

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 24:00:00
#SBATCH --mem=16G
#SBATCH -J Busco
#SBATCH -o /mnt/research/avian/teal/QSTAT/Busco.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

module purge
module load ifort/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 GCC/7.3.0-2.30 OpenMPI/3.1.1 Python/3.6.6
module load BUSCO/3.1.0-Python-2.7.13

cd '$MRT'/OUT

python3 /opt/software/BUSCO/3.1.0-intel-2017a-Python-2.7.13/scripts/run_BUSCO.py -c 8 -i '$MRT'/OUT/Trinity/Trinity.fasta -l /mnt/research/avian/teal/MyBusco -o BUSCO_BWTE_April52019 -m trans

scontrol show job ${SLURM_JOB_ID}' > busco.sh

sbatch busco.sh


