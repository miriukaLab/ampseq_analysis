#!/bin/bash

# functions.sh: tools run during analysis


# Prepare banner for given message

title_banner() {

    echo
	printf "\033[1m\033[36m####################################### \n"
	printf "##  ${1}  ##\n"
	printf "##  ${2}  ##\n"
	printf "#######################################\033[0m \n"
	printf "\033[1m\nAuthor: ${3}\033[0m\n"
	date +"%T"
	echo
}

subtitle_banner() {

    echo
	printf "\033[1m#####################################\n"
	printf "## ${1} ##\n"
	printf "#####################################\033[0m \n"
	echo
}

end_banner() {
	echo
	printf "\033[1m############# \n"
	printf "\033[1;30;107m## ${1} ##\033[0m\n"
	printf "\033[1m#############\033[0m \n"
	echo 
	date +"%T"
	echo
}

export -f title_banner
export -f subtitle_banner
export -f end_banner




##Check if files exists and their extension
## usage: provide input directory

check_files() {
	RAW_DATA="${1}"
	while true; do
		if [ -d "${RAW_DATA}" ]; then
			printf "${RAW_DATA} \033[1m\033[36m OK \033[0m\n"
			### checking fastq extension --> ".gz"
			shopt -s nullglob
			for file in "${RAW_DATA}"/*.{fq,fastq,fastq.gz}
				do
					if [[ "${file}" =~ \.fastq$ ]] || [[ "${file}" =~ \.fq$ ]]; then
						gzip "${file}"
						printf "${file} \033[1m\033[36m OK \033[0m\n...compressing...\n"
					elif [[ "${file}" =~ \.gz$ ]]; then
						printf "${file} \033[1m\033[36m OK \033[0m\n"
					else
						echo
						printf "\033[1m\033[31mError!! wrong extension in raw data\033[0m\n"
						exit 1
					fi
			done
		break
		else
			printf "\033[1m\033[31m Error: ${RAW_DATA} not found. Cannot continue.\033[0m\n"
			echo
			
			read -p "Please, provide raw data directory here: " userdir
			export RAW_DATA="${userdir}"
		fi
	done
}


##Check if destination exists, otherwise it creates it
## usage: provide directory to check

check_outdir() {
	if [ -d "${1}" ]; then
		echo
  		printf "${1} OK\n"
	else
		echo
  		printf "${1} not found. Creating....\n"
		mkdir "${1}"
	fi
}



##FastQC quality check of raw sequencing reads
## usage: provide input and output directory to function

qualifastqc() {
    for i in "${1}"/*.fastq.gz
        do
            printf "\nRunning FastQC to "${i}"\n"
            fastqc "${i}" -o "${2}"
    done

    # Producing merged report
    multiqc -p -ip "${2}" -o "${2}"
}



# crispresso2 in batch mode
run_crispresso_batch() {
    CRISPRessoBatch --batch_settings "${BATCH_FILE}" -p "${CORES}"\
                    --amplicon_seq "${AMP_SEQ}"\
                    --amplicon_name "${AMP_NAME}"\
                    --guide_seq "${GUIDE_SEQ}"\
                    --quantification_window_size "${QUANTIF_WD_SIZE}"\
                    --expected_hdr_amplicon_seq "${EXPECTED_HDR_AMP_SEQ}"\
                    --min_identity_score "${MIN_ID_SCORE}"\
                    --window_around_sgrna "${WD_AROUND_SGRNA}"\
                    --batch_output_folder "${1}"\
                    --skip_failed
}

# crispresso2 in normal mode
run_crispresso() {
    if [ -n "${FASTQR2}" ]; then
        
        printf "Running CRISPResso2 for pair-end reads"
        
        CRISPResso --fastq_r1 "${FASTQR1}" --fastq_r2 "${FASTQR2}"\
                --amplicon_seq "${AMP_SEQ}"\
                --amplicon_name "${AMP_NAME}"\
                --guide_seq "${GUIDE_SEQ}"\
                --quantification_window_size "${QUANTIF_WD_SIZE}"\
                --expected_hdr_amplicon_seq "${EXPECTED_HDR_AMP_SEQ}"\
                --min_identity_score "${MIN_ID_SCORE}"\
                --window_around_sgrna "${WD_AROUND_SGRNA}"\
                --name "${NAME}"\
                --output_folder "${1}"
                
    else

        printf "Running CRISPResso2 for single-end reads"

        CRISPResso --fastq_r1 "${FASTQR1}"\
                --amplicon_seq "${AMP_SEQ}"\
                --amplicon_name "${AMP_NAME}"\
                --guide_seq "${GUIDE_SEQ}"\
                --quantification_window_size "${QUANTIF_WD_SIZE}"\
                --expected_hdr_amplicon_seq "${EXPECTED_HDR_AMP_SEQ}"\
                --min_identity_score "${MIN_ID_SCORE}"\
                --window_around_sgrna "${WD_AROUND_SGRNA}"\
                --name "${NAME}"\
                --output_folder "${1}"
        
    fi
}