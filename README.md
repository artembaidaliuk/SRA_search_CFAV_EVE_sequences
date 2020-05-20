# SRA_search_CFAV_EVE_sequences
SRA search for CFAV EVE sequences performed for the study 'Non-retroviral endogenous viral element limits cognate virus replication 2 in Aedes aegypti ovaries' by Suzuki, Baidaliuk et al., 2020. https://www.biorxiv.org/content/10.1101/751362v1.full

This is a small program to do 'blastn_vdb' on SRA files with SRA-tools https://github.com/ncbi/sra-tools. Unlike directly calling blastn_vdb, in this script the SRA files are first downloaded with 'prefetch' into the cache directory. As soon as each file is downloaded the other script starts 'blastn_vdb' on the local file. The advantage over directly running 'blastn_vdb' is that some time could be saved due to 'prefetch' downloading for each next file in parallel with 'blastn_vdb' on the previous files.


The prefetch is normal and it will put the .sra files in whatever directory assigned beforehand or default.
In order not to fill up the home directory of the desktop, cache is changed by running these commands after SRA-tools have been downloaded:

`mkdir -p ~/.ncbi`

`$ echo '/repository/user/main/public/root = "/full/path/to/the/desired/cache/directory"' > ~/.ncbi/user-settings.mkfg`

Check http://databio.org/posts/downloading_sra_data.html

Relocate to the working directory (change it in this script SRA_blast.sh too).

`$ cd /your/working/directory`

Split accessions in batches in advance to not fill up the storage too quickly and to run on several computers if needed.
Put the accession list files in /your/working/directory/accession_batches/ directory and name sra_accn_batch_NUMBER.txt with the batch number at the end (e. g. /your/working/directory/accession_batches/sra_accn_batch_4.txt).

Make sure your reference sequence is present in the working directory. In this example CFAV-KPP.fasta. Rename it in SRA_blast.sh if changed.

Run for example batch 4:

`$ ./SRA_blast.sh 4`
