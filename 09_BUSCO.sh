#==================================================================================================
#   File: 09_BUSCO.sh
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

cd /mnt/home/homolaj1/Software/busco

echo '#!/bin/sh 
#SBATCH -t 5-0:00:00
#SBATCH --mem=64G
#SBATCH -J Busco
#SBATCH -o /mnt/home/homolaj1/Software/busco/Busco.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module purge
module load GCC/6.4.0-2.28  OpenMPI/2.1.2
module load Python/3.6.4
module load BLAST+/2.2.31
module load HMMER/3.1b2

python3 /mnt/home/homolaj1/Software/busco/scripts/run_BUSCO.py -c 12 -i /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta --out BWTE_Oct2019 -m transcriptome --lineage_path /mnt/home/homolaj1/Software/busco/aves_odb9 -f

scontrol show job ${SLURM_JOB_ID}' > busco.sh

sbatch busco.sh


