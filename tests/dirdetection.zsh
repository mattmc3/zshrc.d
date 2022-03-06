0=${(%):-%N}
@echo "=== ${0:t:r} ==="

# use a tempdir as our ZDOTDIR
tmpdir=$(mktemp -d)
ZDOTDIR=$tmpdir
REPLY=

source ${0:A:h}/../zshrc.d.plugin.zsh 2> /dev/null
@test "sourcing zshrc.d.zsh fails b/c .zshrc.d is missing" $? -eq 1
REPLY=

mkdir $tmpdir/.zshrc.d
echo 'REPLY=.zshrc.d' > $tmpdir/.zshrc.d/a.zsh
mkdir $tmpdir/zshrc.d
echo 'REPLY=zshrc.d' > $tmpdir/zshrc.d/b.zsh
source ${0:A:h}/../zshrc.d.plugin.zsh 2> /dev/null
@test "sourcing zshrc.d.zsh succeeds" $? -eq 0
@test 'detected zshrc.d properly' "$REPLY" = zshrc.d

REPLY=
rm -rf $tmpdir/zshrc.d
source ${0:A:h}/../zshrc.d.plugin.zsh 2> /dev/null
@test "sourcing zshrc.d.zsh succeeds" $? -eq 0
@test 'detected .zshrc.d properly' "$REPLY" = .zshrc.d

# teardown
[[ -d $tmpdir ]] && rm -rf $tmpdir
