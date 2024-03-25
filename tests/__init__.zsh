#!/bin/zsh
##? substenv - substitutes string parts with environment variables
function substenv {
  local -a args=($@)
  (( $#args )) || args=(HOME)
  local -a sedargs=()
  local argv
  for argv in $args; do
    sedargs+=('-e' "s|${(P)argv}|\$${argv}|g")
  done
  sed -E "${sedargs[@]}"
}

function collect-input {
  local -a input=()
  if (( $# > 0 )); then
    input=("${(s.\n.)${@}}")
  elif [[ ! -t 0 ]]; then
    local data
    while IFS= read -r data || [[ -n "$data" ]]; do
      input+=("$data")
    done
  fi
  printf '%s\n' "${input[@]}"
}

function t_setup {
  # works with BSD and GNU gmktemp
  typeset -gx T_TEMPDIR=$(mktemp -d -t t_zshrcd.XXXXXXXX)
  typeset -gx OLD_ZDOTDIR=$ZDOTDIR
  typeset -gx OLD_HOME=$HOME
  typeset -gx HOME=$T_TEMPDIR
  # typeset -gx ZDOTDIR=$T_TEMPDIR/.zsh
  mkdir -p $T_TEMPDIR/.zsh
}

function t_setup_rc_files {
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

  local f fp
  for f in $files; do
    fp=${1:-$T_TEMPDIR/.zshrc.d}/${f}
    [[ -d "${fp:h}" ]] || mkdir -p ${fp:h}
    echo "echo 'sourced file:' '${fp}'" >| ${fp}
  done
  echo "echo 'sourced file:' '$T_TEMPDIR/foo.zsh'" >| $T_TEMPDIR/foo.zsh
  ln -s $T_TEMPDIR/foo.zsh ${1:-$T_TEMPDIR/.zshrc.d}/sym.zsh
}

function t_teardown {
  if [[ -d "$T_TEMPDIR" ]] && [[ ${T_TEMPDIR:A} =~ '/(var|tmp)/*' ]]; then
    rm -rf $T_TEMPDIR
  else
    echo "WARNING: \$T_TEMPDIR not found: '$T_TEMPDIR'"
  fi
  typeset -gx ZDOTDIR=$OLD_ZDOTDIR
  typeset -gx HOME=$OLD_HOME
  unset T_TEMPDIR OLD_{HOME,ZDOTDIR}
}

function t_reset {
  t_teardown
  t_setup
}

function t_mock_source {
  if (( $# == 0 )); then
    echo >&2 "mock source: not enough arguments"
    return 1
  fi
  local srcfile
  for srcfile in $@; do
    if [[ -r "$srcfile" ]]; then
      echo "mock sourcing file... $srcfile"
    else
      echo >&2 "mock source: no such file or directory: $srcfile"
      return 1
    fi
  done
}
