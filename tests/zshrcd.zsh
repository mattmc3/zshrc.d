#!/usr/bin/env zsh
0=${(%):-%x}
BASEDIR=${0:A:h:h}
source $ZTAP_HOME/ztap3.zsh
ztap_header "${0:t:r}"

# pre-tests
@test '$sourced_files is empty' ${#sourced_files} -eq 0

source ${0:a:h}/includes/bootstrap.zsh
setup

@test 'zshrc.d exists' -d $TEST_TEMPDIR
typeset -f source_zshrcd > /dev/null
@test '$sourced_files contains 5 elements' ${#sourced_files} -eq 5
@test '$sourced_files is properly alphabetical' "${sourced_files}" = "a.zsh b.sh b.zsh c.sh sym.zsh"
@echo "The following files were sourced: ${sourced_files}"
existing_files=($TEST_TEMPDIR/**/*)
existing_files=(${existing_files:t})
existing_files=(${existing_files#$TEST_TEMPDIR/})
@echo "The following files/dirs existed in the directory: ${existing_files}"

teardown
ztap_footer
