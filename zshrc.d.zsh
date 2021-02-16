function source_conf_dir() {
  emulate -L zsh; setopt local_options extended_glob null_glob

  # confdir is passed in, or use the zstyle setting, or the default location
  # default location is ~/.zshrc.d, or $ZDOTDIR/zshrc.d
  local confdir="$1"
  if [[ -z "$confdir" ]]; then
    zstyle -s ':zshrc.d:*' 'path' confdir || {
      confdir="${ZDOTDIR:-$HOME}/.zshrc.d"
      [[ ! -d "$confdir" ]] && [[ -n "$ZDOTDIR" ]] && confdir="${ZDOTDIR}/zshrc.d"
    }
  fi

  # make sure we found the conf dir
  [[ ! -d "$confdir" ]] && echo "source_conf_dir: config dir not found $confdir" >&2 && return 1

  # source all files in confdir
  local files=("$confdir"/*.{sh,zsh})
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
