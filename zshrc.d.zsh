function source-zshrcd {
  setopt extended_glob

  # glob search for the zshrc.d dir
  local zshrcd=(
    $ZSHRCD(/N)
    $ZDOTDIR/zshrc.d(/N)
    $ZDOTDIR/conf.d(/N)
    ${ZDOTDIR:-$HOME}/.zshrc.d(/N)
  )
  zshrcd=$zshrcd[1]

  if [[ ! -d "$zshrcd" ]]; then
    echo >&2 "zshrc.d: dir not found '${ZSHRCD:-${ZDOTDIR:-$HOME}/.zshrc.d}'"
    return 1
  fi

  # source files in zshrc.d in order
  local conf_files=("$zshrcd"/*.{sh,zsh}(N))
  local f
  for f in ${(o)conf_files}; do
    # ignore files that begin with a tilde
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}
source-zshrcd
