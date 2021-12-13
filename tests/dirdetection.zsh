0=${(%):-%N}
@echo "=== ${0:t:r} ==="

# use a tempdir as our ZDOTDIR
tmpdir=$(mktemp -d)
ZDOTDIR=$tmpdir
ZSHRCD=

source ${0:A:h}/../zshrc.d.plugin.zsh 2> /dev/null
@test "sourcing zshrc.d.zsh fails b/c .zshrc.d is missing" $? -eq 1
ZSHRCD=

mkdir $tmpdir/.zshrc.d
mkdir $tmpdir/zshrc.d
source ${0:A:h}/../zshrc.d.plugin.zsh 2> /dev/null
@test "sourcing zshrc.d.zsh succeeds" $? -eq 0
@test 'detected zshrc.d properly' $ZSHRCD = $tmpdir/zshrc.d

ZSHRCD=
rm -rf $tmpdir/zshrc.d
source ${0:A:h}/../zshrc.d.plugin.zsh 2> /dev/null
@test "sourcing zshrc.d.zsh succeeds" $? -eq 0
@test 'detected .zshrc.d properly' $ZSHRCD = $tmpdir/.zshrc.d

# teardown
[[ -d $tmpdir ]] && rm -rf $tmpdir
