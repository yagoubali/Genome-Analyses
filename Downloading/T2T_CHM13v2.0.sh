#/usr/bin/env bash

## I will download each file in a seprate zipped, as when download all in a single file, some errors arrose 
##    error:  invalid compressed data to inflate


## un comment the line below to download all files into a single  zipped file. 
#curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_009914755.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_009914755.1.zip" -H "Accept: application/zip"

files_for_download=("GENOME_FASTA" "GENOME_GFF" "RNA_FASTA" "CDS_FASTA" "PROT_FASTA" "SEQUENCE_REPORT")
url='https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_009914755.1/download?'
http_header='"Accept: application/zip"'
for file in "${files_for_download[@]}"; do
     link="\"${url}include_annotation_type=${file}&filename=${file}.zip\" -H ${http_header}"
     echo "downloading ${file} ..."
     echo ${link}
     download="curl -OJX GET ${link}"
     eval ${download}  ## run string as a command
     unzip -o ${file}.zip
     rm ${file}.zip
done
