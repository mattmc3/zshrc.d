# get the config options
zstyle -s ':zshrc.d:*' 'conf-dir' _zshrcdir ||
  _zshrcdir=${ZDOTDIR:-$HOME}/.zshrc.d
# no need to hide zshrc.d in $ZDOTDIR, so try that too
if [[ -n $ZDOTDIR ]] && [[ -d ${ZDOTDIR}/zshrc.d ]]; then
  _zshrcdir=${ZDOTDIR}/zshrc.d
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
source_confdir $_zshrcdir
unset _zshrcdir
