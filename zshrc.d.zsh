() {
  # determine zshrc.d
  local ZSHRCD=$ZSHRCD
  if [[ -z "$ZSHRCD" ]]; then
    if [[ -d "$ZDOTDIR/zshrc.d" ]]; then
      ZSHRCD="$ZDOTDIR/zshrc.d"
    elif [[ -d "$ZDOTDIR/conf.d" ]]; then
      ZSHRCD="$ZDOTDIR/conf.d"
    else
      ZSHRCD="${ZDOTDIR:-$HOME}/.zshrc.d"
    fi
  fi
  # make sure we found the zshrc.d
  if [[ ! -d "$ZSHRCD" ]]; then
    echo >&2 "zshrc.d: dir not found '$ZSHRCD'" && return 1
  fi
  # source all files in zshrc.d
  local conf_files=("$ZSHRCD"/*.{sh,zsh}(N))
  local f
  for f in ${(o)conf_files}; do
    # ignore files that begin with a tilde
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}
