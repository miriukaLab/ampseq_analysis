# AMPSEQ_ANALYSIS
Pipeline for read quality check and amplicon seq analysis/visualization based on **Fastqc** and **CRISPResso2**:

* fastqc quality check (alone or integrated with pipeline)
* CRISPResso2 in normal or batch mode for single or pair-end data
* Read the whole README file before running (it's not long)

&nbsp;

&nbsp;


# installation and requirements
* miniconda (check installation in https://docs.conda.io/en/latest/miniconda.html)
* fastqc (needs java runtime installed, check https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc)
* multiqc (installation below)
* CRISPResso2 (installation below)

> **Note 1:** using conda is not mandatory. You may install multiqc via pip and CRISPResso via docker.

&nbsp;

## create new environment and activate it
```bash
$ conda create -n ampseq -c bioconda -c conda-forge python=3.9 crispresso2 multiqc
$ conda activate ampseq
```

&nbsp;

## get ampseq_analysis 
Clone OR download ampseq_analysis repository to your computer:

```bash
# clone repo using git (needs git to be installed)
$ git clone https://github.com/miriukaLab/ampseq_analysis.git
$ cd ampseq_analysis
$ chmod a+x amplugged
```

```bash
# download zip to your local device
$ curl -L https://github.com/miriukaLab/ampseq_analysis/archive/refs/heads/main.zip -o ampseq_analysis.zip
$ unzip ampseq_analysis.zip
$ rm ampseq_analysis.zip
$ cd ampseq_analysis
$ chmod a+x amplugged
```

&nbsp;

## prepare raw data and files

* Place raw data (.fq|.fastq|.fastq.gz) in known directory, you will need to provide full path to samples when running the pipeline
* Complete "ampseq_analysis/**parameters.txt**" file. Note the double quotes ("") next to the variable names (e.g. FASTQR1=""); you have to fill the variable's value within the quotes, unless it is a number (don't use the quotes here)
* if running in batch mode, complete the "ampseq_analysis/**batch.txt**" as it is indicated in the file, providing the full path to the data file ("$HOME/raw_data/sample1_1.fastq.gz")

&nbsp;

# run pipeline (walkthrough)
1) amplugged runs through bash terminal (remember to complete the parameters file)

```bash
# enter ampseq directory
$ cd ampseq_analysis

#run main pipeline
$ ./amplugged
```

Running the command above wil start program.

&nbsp;

2) input/output information

```bash
$ ./amplugged
# if path to raw_data is wrong, an error will be raised and a new directory will be requested (see Note 2 below)
Error: "$HOME/Desktop/wrong_path" not found. Cannot continue.
Please, provide raw data directory here: $HOME/Desktop/raw_data

$HOME/Desktop/raw_data  OK
$HOME/Desktop/raw_data/sample1_1.fastq.gz OK
$HOME/Desktop/raw_data/sample1_2.fastq.gz OK
$HOME/Desktop/raw_data/sample2_1.fastq.gz OK
$HOME/Desktop/raw_data/sample2_2.fastq.gz OK

# path to output directory is checked (see Note 3 below)
"$HOME/Desktop/new_dir_output" not found. Creating....


```

> **Note 2:** if input directory exists, but samples have unknown extension (other than fq, fastq or fastq.gz), the program will exit. Check extensions and run again.

> **Note 3:** if output directory does not exist, the program will create it...so, you just need to provide the path in the parameters file.

&nbsp;

3) Perform (or not) quality check on raw samples with Fastqc
> **Note 4:** if QUALITY_CHECK is set to "no", Fastqc will be skipped. On the contrary, if QUALITY_CHECK is set to "yes", Fastqc will be integrated to the rest of the pipeline. Finally, setting the variable to "only" will run Fastqc on samples and then exit (no CRISPResso).

&nbsp;

4) Run CRISPResso2 on samples: normal (one sample at a time) or batch (all samples together; same parameters for all)
> **Note 5:** If running in batch mode (default, but can be changed in parameters file), you don't need to provide values for FASTQR1, FASTQR2 and NAME variables in the parameters file. These are all covered in the file.batch.
> **Note 6:** there is no need to indicate that you will be running in single-end mode, just don't fill the FASTQR2 variable when running in normal mode or remove the fastq_r2 column in the file.batch in batch mode.

&nbsp;

5) Go check results...tune parameters...provide new output path to avoid overwriting.

&nbsp;

&nbsp;

Good luck!
* **Alejandro La Greca** | <ale.lagreca@gmail.com> | [GitHub](https://github.com/alelagreca) | [twitter](https://twitter.com/aled_lg)

&nbsp;

Software

**Fastqc**: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ (simon.andrews@babraham.ac.uk)

**CRISPResso2**: https://doi.org/10.1038/s41587-019-0032-3 (https://github.com/pinellolab/CRISPResso2)
