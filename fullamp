#!/bin/bash

START_TIME=$(date +%s)

echo ""
printf "\033[1m\033[31m######################################## \n"
printf "## AMPLICON SEQUENCING FULL PIPELINE \n"
printf "########################################\033[0m \n"
echo -e "\nAuthor: Alejandro La Greca PhD"
echo ""
date +"%T"
echo ""


read -p "Provide full path to samples: " rawdir
if [ -d "${rawdir}" ]; then
  printf "${rawdir} OK\n"
  ### checking fastq extension --> ".gz"
	for file in "${rawdir}"/*
		do
			if [[ "${file}" =~ \.gz$ ]]; then
				printf "${file} OK!\n"
			else
				gzip "${file}"
			fi
		done
else
  printf "Error: ${rawdir} not found. Cannot continue.\n"
  exit 1
fi

read -p "Provide full path to output: " outdir
if [ -d "${outdir}" ]; then
  printf "${outdir} OK\n"
else
  printf "${outdir} not found. Creating....\n"
  mkdir -p ${outdir}/{multiqc,fastqc,crispresso}
fi

### Variables ###
RAW=${rawdir}
WD=${PWD}
SCPT=${WD}/scripts
RES=${outdir}
MQC=${RES}/multiqc
FQC=${RES}/fastqc
CPR=${RES}/crispresso
#################



printf "\033[1m######################################## \n"
printf "## QUALITY CHECK AND FILTERING \n"
printf "########################################\033[0m \n"
echo

cd "${RAW}"
printf "\nRunning FastQC\n"
${SCPT}/./qualityCheck.sh ${FQC}
cd ${FQC}
multiqc -p -ip .
mv multiqc_data ${MQC}/multiqc_data_fastqc
mv multiqc_plots ${MQC}/multiqc_data_fastqc/
mv multiqc_report.html ${MQC}/multiqc_report_fastqc.html



printf "\033[1m######################################## \n"
printf "## QUALITY CHECK AND FILTERING \n"
printf "########################################\033[0m \n"