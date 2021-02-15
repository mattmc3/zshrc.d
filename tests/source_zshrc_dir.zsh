0=${(%):-%N}
@echo "=== ${0:t:r} ==="

# pre-tests
typeset -f source_zshrc_dir > /dev/null
@test 'source_zshrc_dir function does not exist' $? -ne 0

source ${0:a:h}/includes/setup_teardown.zsh
setup "empty"

@test 'zshrc.d exists' -d $TEST_TEMPDIR
typeset -f source_zshrc_dir > /dev/null
@test 'source_zshrc_dir function exists' $? -eq 0

source_zshrc_dir $TEST_TEMPDIR >/dev/null 2>&1
@test 'source_zshrc_dir succeeds when passed a directory that exists' $? -eq 0
source_zshrc_dir >/dev/null 2>&1
@test 'source_zshrc_dir fails when called with zero args' $? -ne 0
source_zshrc_dir /my/fake/dir >/dev/null 2>&1
@test 'source_zshrc_dir fails when called with dir that does not exist' $? -ne 0
