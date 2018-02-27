cwlVersion: v1.0
class: CommandLineTool

baseCommand:

doc: |
  rs-filter-by-5p-adapter.keep5pAdapter.pl has to be in PATH,
  or absolute path has to be given.
  For portability of the polyA preprocessing pipeline, path to local workflow
  repository has to be specified when calling the WF, and the baseCommand for
  select_valid_5p is constructed here in the 'arguments' section.

  executes the script rs-filter-by-5p-adapter.keep5pAdapter.pl
  Usage: perl $0 --adapter=....TTT --gzip file.fa.gz
  Usage for uncompressed fasta files: perl $0 --adapter=....TTT file.fa
  args:
  [inputFile, targetFileName, adapter, zippedInput]

stdout: $(inputs.targetFileName)

requirements:
  - class: InlineJavascriptRequirement

arguments:
  - valueFrom: $(inputs.repo_path + "/commandLineTools/" + inputs.valid5p_exec_path)
    #default: "rs-filter-by-5p-adapter.keep5pAdapter.pl"
    position: 0

inputs:
  valid5p_exec_path:
    type: string?
    default: "select_valid_5p/rs-filter-by-5p-adapter.keep5pAdapter.pl"
  repo_path:
    type: string
  inputFile:
    type: File
    format: edam:format_1929
    inputBinding:
      position: 100
  adapter:
    type: string
    inputBinding:
      position: 5
      prefix: --adapter=
      separate: false
  targetFileName:
    type: string
  zippedInput:
    type: boolean?
    inputBinding:
      position: 6
      prefix: --gzip

outputs:
  valid5pResult:
    type: stdout
    format: edam:format_1929


############################
#s:dateCreated: "2017-11-29"
#s:author:
#  - class: s:Person
#    s:email: mailto:christina.herrmann@unibas.ch
#    s:name: Christina J. Herrmann

$namespaces:
#  s: https://schema.org/
  edam: http://edamontology.org/

$schemas:
# - https://schema.org/docs/schema_org_rdfa.html
 - http://edamontology.org/EDAM_1.18.owl
