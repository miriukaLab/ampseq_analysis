# ampseq_analysis
Pipeline for amplicon seq analysis and visualization based on CRISPResso2



## installation and requirements
* miniconda (check installation in https://docs.conda.io/en/latest/miniconda.html)
* fastqc (needs java runtime installed, check https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc)
* multiqc (description below)
* CRISPResso2 (description below)

# create new environment and activate it
conda create -n ampseq -c bioconda -c conda-forge python=3.9 crispresso2 multiqc
conda activate ampseq

## Run pipeline

