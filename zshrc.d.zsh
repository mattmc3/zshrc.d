function source_conf_dir() {
  # The config dir is determined as follows:
  # - confdir argument provided
  # - the zstyle setting is set (ie: zstyle ':zshrc.d:*' 'path' ~/path/to/my/custom/zshrc.d)
  # - or the default location is used (ie: ${ZDOTDIR:-$HOME}/.zshrc.d)
  local confdir
  if [[ $# -gt 0 ]]; then
    confdir="$1"
  else
    zstyle -s ':zshrc.d:*' 'path' confdir || {
      confdir="${ZDOTDIR:-$HOME}/.zshrc.d"
      if [[ ! -d "$confdir" ]] && [[ -d "${ZDOTDIR:-~/.config/zsh}/zshrc.d" ]]; then
        confdir="${ZDOTDIR}/zshrc.d"
      fi
    }
  fi

  # make sure we found the conf dir
  [[ -d "$confdir" ]] || {
    >&2 echo "source_conf_dir: config dir not found $confdir" && return 1
  }

  # source all files in confdir
  local files=("$confdir"/*.{sh,zsh}(N))
  local f; for f in ${(o)files}; do
    # ignore files that begin with a tilde
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}

() {
  local defer_confdir
  zstyle -b ':zshrc.d:*' 'defer' defer_confdir || defer_confdir=no
  [[ $defer_confdir = yes ]] || source_conf_dir
}
