# get the config options
zstyle -s ':zshrc.d:*' 'path' _zshrcdir
if [[ $? -ne 0 ]]; then
  _zshrcdir=${ZDOTDIR:-$HOME}/.zshrc.d
  # no need to hide zshrc.d in $ZDOTDIR, so try that too
  if [[ -n $ZDOTDIR ]] && [[ ! -d $_zshrcdir ]]; then
    _zshrcdir=${ZDOTDIR}/zshrc.d
  fi
fi

function source_zshrcdir() {
  # source all ZSH config files in a directory
  local configdir="$1"
  [[ -z "$configdir" ]] && echo "expecting config dir argument" >&2 && return 1
  [[ ! -d "$configdir" ]] && echo "config dir not found: $configdir" >&2 && return 1

  # source configdir
  local f
  local files=("$configdir"/*.{sh,zsh}(.N))
  for f in ${(o)files}; do
    # ignore files that begin with a tilde
    case $f:t in ~*) continue;; esac
    source "$f"
  done
}
source_zshrcdir $_zshrcdir
unset _zshrcdir
