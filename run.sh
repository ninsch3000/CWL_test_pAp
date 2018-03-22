#!/bin/bash
# (c) 2018 Alexander Kanitz

# IMPORTANT:
# - Ensure that you are in the root directory of this repository when executing these tests
# - Prior to execution of the pre-fetch tests, create a directory 'images' and pull images there

# Execute pipeline tests
./run_test.cwl-runner.local.mod.singularity.prefetch.sh 2>&1 | tee run_test.cwl-runner.local.mod.singularity.prefetch.log
./run_test.cwl-runner.local.mod.singularity.pull.sh 2>&1 | tee run_test.cwl-runner.local.mod.singularity.pull.log
./run_test.toil.local.mod.singularity.prefetch.sh 2>&1 | tee run_test.toil.local.mod.singularity.prefetch.log
./run_test.toil.local.mod.singularity.pull.sh 2>&1 | tee run_test.toil.local.mod.singularity.pull.log
./run_test.toil.remote.mod.singularity.prefetch.sh 2>&1 | tee run_test.toil.remote.mod.singularity.prefetch.log

# 2018-03-21 - all tests succeeded
