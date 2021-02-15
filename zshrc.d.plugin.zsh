# set the location of zshrc.d
zstyle -s ':zshrc.d:*' 'path' _zshrcdir || {
  if [[ -n "$ZDOTDIR" ]] && [[ -d "$ZDOTDIR/zshrc.d" ]]; then
    _zshrcdir="$ZDOTDIR/zshrc.d"
  else
    _zshrcdir="${ZDOTDIR:-$HOME}/.zshrc.d"
  fi
}

function source_zshrc_dir() {
  emulate -L zsh; setopt local_options extended_glob null_glob

  # source all ZSH config files in a directory
  local configdir="$1"
  [[ -z "$configdir" ]] && echo "source_zshrc_dir: expecting config dir argument" >&2 && return 1
  [[ ! -d "$configdir" ]] && echo "source_zshrc_dir: config dir not found $configdir" >&2 && return 1

  # source configdir
  local f
  local files=("$configdir"/*.{sh,zsh})
  for f in ${(o)files}; do
    # ignore files that begin with a tilde
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}
source_zshrc_dir $_zshrcdir
unset _zshrcdir
