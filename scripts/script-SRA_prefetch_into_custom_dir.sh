#!/bin/bash

samples_acc=$1 #### file with list of SRR accessions for the current batch
_directory=$2 #### working directory
_accn_batch_num=$3 #### batch number

cd $_directory/blastn_vdb_out/  #### output directory

for s in $samples_acc
do

#echo $s
echo "start_downloading" >> "$_directory/error_messages_prefetch_for_accn_batch_${_accn_batch_num}.txt"
echo $s >> "$_directory/error_messages_prefetch_for_accn_batch_${_accn_batch_num}.txt"
~/Documents/Tools/sratoolkit.2.9.6-1-mac64/bin/prefetch $s --max-size 200000000 \
2>> "$_directory/error_messages_prefetch_for_accn_batch_${_accn_batch_num}.txt"
sleep 120
echo "end_downloading" >> "$_directory/error_messages_prefetch_for_accn_batch_${_accn_batch_num}.txt"
echo "---------------" >> "$_directory/error_messages_prefetch_for_accn_batch_${_accn_batch_num}.txt"
####### signal main script about download completion
echo "$s" >> "$_directory/temporary_file_for_accn_batch_${_accn_batch_num}.txt"

done

echo "***************" >> "$_directory/error_messages_prefetch_for_accn_batch_${_accn_batch_num}.txt"
echo "all .sra files with accessions from batch #$_accn_batch_num are downloaded" >> "$_directory/error_messages_prefetch_for_accn_batch_${_accn_batch_num}.txt"
