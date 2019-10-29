#==================================================================================================
#   File: 05_SILVAFilter.sh
#   Date: 10/28/19
#   Description: Filter reads for rRNA using SILVA databases
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

mkdir $MRT/OUT/SILVA/metrics
mkdir $MRT/QSTAT/SILVA
mkdir $MRT/SHELL/SILVA

cd $MRT/SHELL

ls $MRT/OUT/Trimmomatic/paired | grep "R1" | sed 's/_R1_pe.fastq\.gz//g' | while read -r LINE
do

echo '#!/bin/sh 
#SBATCH -t 6:00:00
#SBATCH --mem=64G
#SBATCH -J SILVAFilter
#SBATCH -o '$MRT'/QSTAT/SILVA/'$LINE'.SILVAFilter.o
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

module load GCC/5.4.0-2.26 OpenMPI/1.10.3
module load Bowtie2/2.2.3

cd '$MRT'/OUT

bowtie2 --very-sensitive-local \
    --phred33 \
    --quiet \
    -x ./SILVA/SILVA_DB \
    -1 ./Trimmomatic/paired/'$LINE'_R1_pe.fastq.gz \
    -2 ./Trimmomatic/paired/'$LINE'_R2_pe.fastq.gz \
    --threads 12 \
    --met-file ./SILVA/metrics/'$LINE'_bowtie2_metrics.txt \
    --al-conc-gz ./SILVA/rRNA_paired_'$LINE'.fq.gz \
    --un-conc-gz ./SILVA/nonRRNA_paired_'$LINE'.fq.gz \
    --al-gz ./SILVA/rRNA_unpaired_'$LINE'.fq.gz \
    --un-gz ./SILVA/nonRRNA_unpaired'$LINE'.fq.gz

scontrol show job ${SLURM_JOB_ID}' > ./SILVA/SILVAFilter."$LINE".sh

sbatch ./SILVA/SILVAFilter."$LINE".sh

done
