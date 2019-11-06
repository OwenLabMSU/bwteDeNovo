#==================================================================================================
#   File: 11_BUSCO.sh
#   Date: 11/03/19
#   Description: Run BUSCO to estimate completeness of transcriptome assembly
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal

mkdir $MRT/OUT/BUSCO

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 2-12:00:00
#SBATCH --mem=64G
#SBATCH -J Busco
#SBATCH -o '$MRT'/QSTAT/Busco.o
#SBATCH --nodes=1-8
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module purge
module load GCC/6.4.0-2.28  OpenMPI/2.1.2
module load Python/3.6.4
module load BUSCO/3.1.0-Python-3.6.4

#cd '$MRT'/OUT/BUSCO

#wget https://busco.ezlab.org/datasets/aves_odb9.tar.gz 
#tar xvzf aves_odb9.tar.gz

cd '$MRT'/OUT

python3 /mnt/home/homolaj1/Software/busco/scripts/run_BUSCO.py -c 12 -i ./transrate/cdhit.trinity/good.cdhit.trinity.fasta --out BWTE_Oct2019 -m transcriptome --lineage_path ./BUSCO/aves_odb9 -f

scontrol show job ${SLURM_JOB_ID}' > busco.sh

sbatch busco.sh


