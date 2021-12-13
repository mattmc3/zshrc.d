0=${(%):-%N}
@echo "=== ${0:t:r} ==="

source ${0:a:h}/includes/bootstrap.zsh

@test '$sourced_files contains 0 elements' ${#sourced_files} -eq 0
zstyle ':zshrc.d:*' 'defer' true
setup

typeset -f source_conf_dir > /dev/null
@test 'source_conf_dir function exists, but was not called' $? -eq 0
@test '$sourced_files still contains 0 elements' ${#sourced_files} -eq 0

teardown
