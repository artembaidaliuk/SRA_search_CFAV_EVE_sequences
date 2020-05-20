#!/bin/bash

#### the prefetch is normal and it will put the .sra files in whatever directory you assign beforehand or default

#### In order not to fill up the home directory of the desktop, downloading directory
#### is changed by running these commands after SRA-tools have been downloaded:

#### mkdir -p ~/.ncbi
#### $ echo '/repository/user/main/public/root = "/full/path/to/the/volume"' > ~/.ncbi/user-settings.mkfg
#### Check http://databio.org/posts/downloading_sra_data.html




#### To run the program, relocate to the working directory (change it in this script if here)
## $ cd /your/working/directory

#### split accessions in batches in advance to not fill up the storage too quickly and to run on several computers if needed
#### Put the accession list files in $_directory/accession_batches/ directory and name
#### sra_accn_batch_##.txt with the batch number at the end

#### Make sure your reference sequence is present in the working directory. In this exaple CFAV-KPP. Rename it here in the script if needed.


## Run for example batch 4:
## $ ./SRA_blast.sh 4


_accn_batch_num=$1 #### batch number
_directory="/your/working/directory" #### input here your working directory

samples_acc=`cat $_directory/accession_batches/sra_accn_batch_${_accn_batch_num}.txt` #####  the file with accessions

#####  create the output folder
if [ ! -d "$_directory/blastn_vdb_out" ]; then
mkdir $_directory/blastn_vdb_out
fi

#####  call another script that will prefetch
/bin/bash $_directory/scripts/script-SRA_prefetch_into_custom_dir.sh \
"$samples_acc" "$_directory" "$_accn_batch_num" &

for s in $samples_acc; do
  while true; do
    if grep -Fxq "$s" $_directory/temporary_file_for_accn_batch_${_accn_batch_num}.txt
    then
    echo "$s SRA downloaded already!!!"
    break
    else
    echo "$s sra not downloaded yet"
    sleep 120
  fi
  done
  echo "$s blastn_vdb processing it now"

  echo "start_blast" >> "$_directory/error_messages_blastn_vdb_for_accn_batch_${_accn_batch_num}.txt"
  echo $s >> "$_directory/error_messages_blastn_vdb_for_accn_batch_${_accn_batch_num}.txt"

~/Documents/Tools/sratoolkit.2.9.6-1-mac64/bin/blastn_vdb \
-db $s \
-query $_directory/CFAV-KPP.fasta \
-out $_directory/blastn_vdb_out/${s}.out \
-outfmt 6 -sra_mode 2 \
2>> "$_directory/error_messages_blastn_vdb_for_accn_batch_${_accn_batch_num}.txt"


  echo "end_blast" >> "$_directory/error_messages_blastn_vdb_for_accn_batch_${_accn_batch_num}.txt"

done



if [ ! -d "$_directory/local_trash" ]; then
mkdir $_directory/local_trash
fi

if [ ! -d "$_directory/error_messages" ]; then
mkdir $_directory/error_messages
fi

mv $_directory/temporary_file_for_accn_batch_${_accn_batch_num}.txt $_directory/local_trash
mv $_directory/error_messages_prefetch_for_accn_batch_${_accn_batch_num}.txt $_directory/error_messages
mv $_directory/error_messages_blastn_vdb_for_accn_batch_${_accn_batch_num}.txt $_directory/error_messages
