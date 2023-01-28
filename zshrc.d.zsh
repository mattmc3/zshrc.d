function source-zshrcd {
  setopt extended_glob

  # glob search for the zshrc.d dir
  local -a zshrcd=()
  [[ -n "$ZSHRCD" ]] && zshrcd+=($ZSHRCD(N))
  [[ -n "$ZDOTDIR" ]] && zshrcd+=(
    $ZDOTDIR/zshrc.d(N)
    $ZDOTDIR/conf.d(N)
    $ZDOTDIR/rc.d(N)
  )
  zshrcd+=(${ZDOTDIR:-$HOME}/.zshrc.d(N))

  if ! (( $#zshrcd )); then
    echo >&2 "zshrc.d: dir not found '${ZSHRCD:-${ZDOTDIR:-$HOME}/.zshrc.d}'"
    return 1
  fi

  local -a conf_files=("$zshrcd[1]"/*.{sh,zsh}(N))
  local rcfile
  # sort and source conf files
  for rcfile in ${(o)conf_files}; do
    # ignore files that begin with a tilde
    case ${rcfile:t} in '~'*) continue;; esac
    source "$rcfile"
  done
}
source-zshrcd
