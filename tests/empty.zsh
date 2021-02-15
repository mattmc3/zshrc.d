0=${(%):-%N}
@echo "=== ${0:t:r} ==="

# pre-tests
@test '$sourced_files is empty' ${#sourced_files} -eq 0

source ${0:a:h}/includes/setup_teardown.zsh
setup "empty"

@test 'zshrc.d exists' -d $TEST_TEMPDIR
@test '$sourced_files is still empty' ${#sourced_files} -eq 0

teardown
