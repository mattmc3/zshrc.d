#!/usr/bin/env zsh
0=${(%):-%x}
BASEDIR=${0:A:h:h}
source $ZTAP_HOME/ztap3.zsh
ztap_header "${0:t:r}"

# pre-tests
@test '$sourced_files is empty' ${#sourced_files} -eq 0

source ${0:a:h}/includes/bootstrap.zsh
setup "empty"

@test 'zshrc.d exists' -d $TEST_TEMPDIR
@test '$sourced_files is still empty' ${#sourced_files} -eq 0

ztap_footer
