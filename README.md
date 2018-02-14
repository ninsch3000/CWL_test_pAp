# Mini Test Pipeline for polyA-Site pre-processing
## Objective
This workflow does pre-processing of Aseq data for the polyA pipeline.
Sequencing data are converted to fasta, checked for valid 5'' and 3'' ends and reverse complemented.

## Steps
  - gnu_zip fastq
  - fastq_to_fasta
  - rs-filter-by-5p-adapter.keep5pAdapter.pl
  - cutadapt
  - fastx_reverse_complement
  - gzip

## requirements
  - cwl-runner
  - docker/singularity
> Note: Currently only the docker requirement for fastx_reverse_complement is implemented. Other steps will follow.
