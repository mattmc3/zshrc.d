0=${(%):-%N}
TESTS_HOME=${0:a:h:h}
TEST_TEMPDIR=
ZSHRCD=
fpath+=$TESTS_HOME/functions
for _fn in $TESTS_HOME/functions/*(.N); do
  autoload -Uz $_fn
done
unset _fn
