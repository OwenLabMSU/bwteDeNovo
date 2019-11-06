#==================================================================================================
#   File: 13_TrinotateBlastx.sh
#   Date: 11/03/19
#   Description: Use blastx within Trinotate to annotate transcripts using SwissProt
#==================================================================================================

#Define alias for project root directory
MRT=/mnt/research/avian/teal
SCR=/mnt/gs18/scratch/users/homolaj1/teal

cd $MRT/SHELL

echo '#!/bin/sh 
#SBATCH -t 4-0:00:00 
#SBATCH --mem=48G 
#SBATCH -J Blastx
#SBATCH -o '$MRT'/QSTAT/Trinotate_Blastx.o
#SBATCH --nodes=1-12
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16

module purge
module load icc/2017.4.196-GCC-6.4.0-2.28 impi/2017.3.196 Trinity/2.6.6
module load icc/2015.1.133-GCC-4.9.2  impi/5.0.2.044 SQLite/3.8.8.1
module load BLAST+/2.2.31
module load icc/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132 HMMER2GO/0.17.8

cd /mnt/home/homolaj1/Software/Trinotate-Trinotate-v3.2.0

blastx -query /mnt/research/avian/teal/OUT/transrate/cdhit.trinity/good.cdhit.trinity.fasta \
    -db uniprot_sprot.pep \
    -num_threads 16 \
    -max_target_seqs 1 \
    -outfmt 6 \
    -evalue 1e-5 > blastx.outfmt6

scontrol show job ${SLURM_JOB_ID}' > Trinotate_blastx.sh

sbatch Trinotate_blastx.sh
