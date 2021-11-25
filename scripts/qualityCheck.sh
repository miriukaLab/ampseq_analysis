#!/bin/bash

##FastQC quality check

outdir="${1}"

function qualifastqc() {
    fastqc ${1} -o ${2}
}

export -f qualifastqc

parallel -j 100% --bar qualifastqc {1} ${outdir} ::: *.fastq.gz













