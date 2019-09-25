#==================================================================================================
#   File: 11a_TrinotateBlastx.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 09/20/19
#   Description: Use blastx within Trinotate to annotate transcripts
#	Run: Interactively - array
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/research/avian/teal/OUT/Trinity
#==================================================================================================

cd /mnt/research/avian/teal/SHELL

echo '#!/bin/sh 
#SBATCH --nodes=1-12
#SBATCH --ntasks=1
#SBATCH -t 3-0:00:00
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=4G
#SBATCH -J Blastx
#SBATCH -o /mnt/research/avian/teal/QSTAT/Blastx.o

module purge
module load icc/2017.4.196-GCC-6.4.0-2.28 impi/2017.3.196 Trinity/2.6.6
module load icc/2015.1.133-GCC-4.9.2  impi/5.0.2.044 SQLite/3.8.8.1
module load BLAST+/2.2.31
module load icc/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132 HMMER2GO/0.17.8

cd /mnt/home/homolaj1/Software/Trinotate-Trinotate-v3.2.0

blastx -query /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta -db uniprot_sprot.pep -num_threads 24 -max_target_seqs 1 -outfmt 6 -evalue 1e-5 > blastx.outfmt6

scontrol show job ${SLURM_JOB_ID}' > blastx.sh

sbatch blastx.sh
