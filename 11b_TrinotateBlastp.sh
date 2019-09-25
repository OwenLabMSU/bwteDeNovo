#==================================================================================================
#   File: 11b_TrinotateBlastp.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 09/20/19
#   Description: Use blastp within Trinotate to annotate transcripts ORFs identified via transdecoder
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
#SBATCH -t 2-0:00:00
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=4G
#SBATCH -J Blastp
#SBATCH -o /mnt/research/avian/teal/QSTAT/Blastp.o

module purge
module load icc/2017.4.196-GCC-6.4.0-2.28 impi/2017.3.196 Trinity/2.6.6
module load icc/2015.1.133-GCC-4.9.2  impi/5.0.2.044 SQLite/3.8.8.1
module load BLAST+/2.2.31
module load icc/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132 HMMER2GO/0.17.8

cd /mnt/home/homolaj1/Software/Trinotate-Trinotate-v3.2.0

blastp -query /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta.transdecoder.pep -db uniprot_sprot.pep -num_threads 24 -max_target_seqs 1 -outfmt 6 -evalue 1e-3 > blastp.outfmt6

hmmscan --cpu 12 --domtblout TrinotatePFAM.out Pfam-A.hmm /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta.transdecoder.pep > pfam.log

scontrol show job ${SLURM_JOB_ID}' > blastp.sh

sbatch blastp.sh
