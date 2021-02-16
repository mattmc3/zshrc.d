0=${(%):-%N}
@echo "=== ${0:t:r} ==="

# pre-tests
@test '$sourced_files is empty' ${#sourced_files} -eq 0
typeset -f source_conf_dir > /dev/null
@test 'source_conf_dir function does not exist' $? -ne 0

source ${0:a:h}/includes/setup_teardown.zsh
setup

@test 'zshrc.d exists' -d $TEST_TEMPDIR
typeset -f source_conf_dir > /dev/null
@test 'source_conf_dir function exists' $? -eq 0
@test '$sourced_files contains 5 elements' ${#sourced_files} -eq 5
@test '$sourced_files is properly alphabetical' "${sourced_files}" = "a.zsh b.sh b.zsh c.sh sym.zsh"
@echo "The following files were sourced: ${sourced_files}"
existing_files=($TEST_TEMPDIR/**/*)
existing_files=(${existing_files:t})
existing_files=(${existing_files#$TEST_TEMPDIR/})
@echo "The following files/dirs existed in the directory: ${existing_files}"

teardown
