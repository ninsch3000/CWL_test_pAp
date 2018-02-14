#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0

label: "Aseq pre-processing for the polyA pipeline"

doc: |
    This workflow does pre-processing of Aseq data for the polyA pipeline.
    (*Citation needed*)
    Sequencing data are converted to fasta, checked for valid 5'' and 3'' ends and reverse complemented.
    Steps are:
    - gnu_zip fastq
    - fastq_to_fasta
    - rs-filter-by-5p-adapter.keep5pAdapter.pl
    - cutadapt
    - fastx_reverse_complement
    - gzip

requirements:
   - class: StepInputExpressionRequirement
#  - class: ScatterFeatureRequirement        #needed for cutadapt step
   - class: InlineJavascriptRequirement
#  - class: SubworkflowFeatureRequirement    #needed for mapping subworkflow
#  - class: MultipleInputFeatureRequirement  #catMappings

hints:
  SoftwareRequirement:
    packages:
      fastx-toolkit:
        specs: ["http://identifiers.org/RRID:SCR_005534"]
        version: ["0.0.14"]
      cutadapt:
        specs: ["http://identifiers.org/RRID:SCR_011841"]
        version: ["1.15"]

inputs:
  fastqgz:
    type: File
    label: Reads in .fq.gz format
  outFileName: string?  # name of output file
  adapter5p: string?

outputs:
  result:
    type: File
    #format: edam:format_1929
    outputSource: zip_fasta/zipResult
    #outputSource: cutadapt/cutadapt_fasta_out

steps:
  unzip_fastq:
    run: ../../commandLineTools/gnu_gzip/gnu_gzip.cwl
    in:
      zipFile: fastqgz
      decompress:
        default: true
      targetFileName:
        default: "unzipped_fastq_out_cwl_workflow.fq"
    out: [zipResult]

  fastq_to_fasta:
    run: ../../commandLineTools/fastq_to_fasta/fastq_to_fasta.cwl
    in:
      inputFile:
        source: unzip_fastq/zipResult
        #format: edam:format_1930
      rename:
        default: true # Rename sequences with numbers, doing it here instead of
                      # doing extra step fastx_renamer
      keepUnknown:
        default: false
      targetFileName:
        default: "fastq2fasta_out_cwl_workflow.fa"
    out: [q2aResult]

  select_valid_5p:
    run: ../../commandLineTools/select_valid_5p/select_valid_5p.cwl
    in:
      inputFile: fastq_to_fasta/q2aResult
      adapter:
        source: adapter5p
        default: "....TTT"
      targetFileName:
        default: "valid5p_out_cwl_workflow.fa"
      zippedInput:
        default: false
    out: [valid5pResult]

  cutadapt:
    run: ../../commandLineTools/cutadapt/cutadapt.cwl
    in:
      inputFile: select_valid_5p/valid5pResult
      adapter:
        default: ["TGGAATTCTCGGGTGCCAAGG"] #Has to be array of strings
      minimumLength:
        default: 4 # Override tool's default:0 to avoid empty lines in output file
      targetFileName:
        default: "cutadapt_out_cwl_workflow.fa"
        #source: outFileName
    out: [cutadapt_fasta_out]

  reverse_complement:
    run: ../../commandLineTools/fastx_reverse_complement/fastx_reverse_complement.cwl
    in:
      inputFile: cutadapt/cutadapt_fasta_out
      compress:
        default: false
      targetFileName:
        default: "reverse_complement_out_cwl_workflow.fa"
        #source: outFileName
    out: [reverse_complement_out]

  zip_fasta:
    run: ../../commandLineTools/gnu_gzip/gnu_gzip.cwl
    in:
      zipFile: reverse_complement/reverse_complement_out
      decompress:
        default: false
      targetFileName:
        default: "valid5p_cutadapt_revComp_out_cwl_workflow.fa.gz"
    out: [zipResult]

############################
$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

$schemas:
 - https://schema.org/docs/schema_org_rdfa.html
 - http://edamontology.org/EDAM_1.18.owl

s:dateCreated: "2017-11-29"
s:author:
  - class: s:Person
    s:email: mailto:christina.herrmann@unibas.ch
    s:name: Christina J. Herrmann
