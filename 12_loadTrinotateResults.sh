#==================================================================================================
#   File: 12_loadTrinotateResults.sh
#	Directory code:	/mnt/research/avian/teal/CODE
#   Date: 09/20/19
#   Description: Load trinotate results into a sqlite database for analysis
#	Run: Interactively
#--------------------------------------------------------------------------------------------------
#	Input files in directory:
#		/mnt/scratch/dolinsk5/avian/teal/RAW
#
#	Output files to directories:
#		/mnt/research/avian/teal/OUT/Trinity
#==================================================================================================

cd /mnt/home/homolaj1/Software/Trinotate-Trinotate-v3.2.0/SHELL

module purge
module load icc/2015.1.133-GCC-4.9.2  impi/5.0.2.044 SQLite/3.8.8.1

### Create gene/transcript map
/opt/software/Trinity/2.8.4/util/support_scripts/get_Trinity_gene_to_trans_map.pl /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta >  /mnt/home/homolaj1/Software/Trinotate-Trinotate-v3.2.0/Trinity.fasta.gene_trans_map

### Create initial sqlite database
/mnt/home/homolaj1/Software/Trinotate-Trinotate-v3.2.0/Trinotate Trinotate.sqlite init \
--gene_trans_map /mnt/home/homolaj1/Software/Trinotate-Trinotate-v3.2.0/Trinity.fasta.gene_trans_map \
--transcript_fasta /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta \
--transdecoder_pep /mnt/research/avian/teal/OUT/Trinity/Trinity.fasta.transdecoder.pep

### Load previously generated results
./Trinotate Trinotate.sqlite LOAD_swissprot_blastx blastx.outfmt6
./Trinotate Trinotate.sqlite LOAD_swissprot_blastp ./blastp.outfmt6
./Trinotate Trinotate.sqlite LOAD_pfam TrinotatePFAM.out

### Create Trinotate report
./Trinotate Trinotate.sqlite report -E 1e-5 > Trinotate.csv
