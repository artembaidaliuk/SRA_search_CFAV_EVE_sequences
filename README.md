# SRA_search_CFAV_EVE_sequences
SRA search CFAV-like sequences (potentialy EVEs) performed for the study 'Non-retroviral endogenous viral element limits cognate virus replication in Aedes aegypti ovaries' by Suzuki, Baidaliuk et al., 2020. https://www.biorxiv.org/content/10.1101/751362v1.full (preprint) and https://doi.org/10.1016/j.cub.2020.06.057 (Current Biology).

This is a small program to do 'blastn_vdb' on SRA files with SRA-tools https://github.com/ncbi/sra-tools. Unlike directly running 'blastn_vdb', here SRA files are first downloaded with 'prefetch' into the cache directory. As soon as each file is downloaded 'blastn_vdb' starts on the local file. The advantage over directly running 'blastn_vdb' is that time could be saved due to 'prefetch' downloading for next files in parallel with 'blastn_vdb' on the previous files.

'prefetch' will put the .sra files in the default cache directory or assigned beforehand.
In order to avoid filling up the home directory of the desktop, cache is changed by running these commands after SRA-tools have been downloaded:

`mkdir -p ~/.ncbi`

`$ echo '/repository/user/main/public/root = "/full/path/to/the/desired/cache/directory"' > ~/.ncbi/user-settings.mkfg`

Check http://databio.org/posts/downloading_sra_data.html for more information.

Relocate to the working directory (change it in this script SRA_blast.sh too).

`$ cd /your/working/directory`

Split accessions in batches in advance to not fill up the storage right away and/or to run on several computers if needed.
Put the accession list files in /your/working/directory/accession_batches/ directory and name sra_accn_batch_NUMBER.txt with the batch number at the end (e.g. /your/working/directory/accession_batches/sra_accn_batch_4.txt).

Make sure your reference sequence is present in the working directory. Rename it inside SRA_blast.sh if needed.

Run (e.g. batch 4):

`$ ./SRA_blast.sh 4`

'blastn_vdb_out_XXX' folders contain all non empty raw outputs out off all accessions that were attempted in 'SRR_accessions_XXX'/'SRX_accessions_XXX' files.
Reference sequence European Nucleotide Archive accessions are LR596014 (CFAV-KPP, also GenBank MK860761) and LR694074 (CFAV-Bangkok).
