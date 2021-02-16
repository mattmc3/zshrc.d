() {
  0=${(%):-%x}
  TESTS_HOME=${0:a:h:h}
  TEST_TEMPDIR=
}

function setup() {
  TEST_TEMPDIR=$(mktemp -d)
  @echo "TEST_TEMPDIR=$TEST_TEMPDIR"
  zstyle ':zshrc.d:*' 'path' $TEST_TEMPDIR

  if [[ "$1" != "false" ]] && [[ "$1" != "empty" ]]; then
    local f
    local contents='sourced_files=($sourced_files ${0:a:t})'
    local files=(
      # zsh files
      a.zsh
      b.zsh

      # sh files
      b.sh
      c.sh

      # skip files
      '.hidden.zsh'
      '~skipme.zsh'
      'wrongshell.bash'
    )

    for f in $files; do
      echo $contents >| $TEST_TEMPDIR/${f}
    done

    # symlinks
    mkdir $TEST_TEMPDIR/symlinks
    echo $contents >| $TEST_TEMPDIR/symlinks/symlink_file
    ln -s $TEST_TEMPDIR/symlinks/symlink_file $TEST_TEMPDIR/sym.zsh
  fi

  source ${TESTS_HOME:h}/zshrc.d.plugin.zsh
  @test "sourcing zshrc.d.zsh succeeded" $? -eq 0
}

function teardown() {
  [[ -d "$TEST_TEMPDIR" ]] && rm -rf $TEST_TEMPDIR
  unset TEST_TEMPDIR
}
