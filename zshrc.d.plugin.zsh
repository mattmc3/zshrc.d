# get the config options
zstyle -s ':zshrc.d:*' 'path' _zshrcdir ||
  _zshrcdir=${ZDOTDIR:-$HOME/.config/zsh}/zshrc.d

# source zshrc.d
for _f in "$_zshrcdir"/*.{sh,zsh}(.N); do
  # ignore files that begin with a tilde
  case $_f:t in ~*) continue;; esac
  source "$_f"
done
unset _f _zshrcdir
