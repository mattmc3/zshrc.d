#
# zshrc.d: Use a directory to source .zshrc files, similar to Fish's conf.d.
#

typeset -ga _zshrcd=(
  $ZSHRCD
  ${ZDOTDIR:-/dev/null}/zshrc.d(N)
  ${ZDOTDIR:-/dev/null}/conf.d(N)
  ${ZDOTDIR:-/dev/null}/rc.d(N)
  ${ZDOTDIR:-$HOME}/.zshrc.d(N)
)
if [[ ! -e "$_zshrcd[1]" ]]; then
  echo >&2 "zshrc.d: dir not found '${ZSHRCD:-${ZDOTDIR:-$HOME}/.zshrc.d}'."
  return 1
fi

typeset -ga _zshrcd=("$_zshrcd[1]"/*.{sh,zsh}(N))
typeset -g _zshrcd_file
for _zshrcd_file in ${(o)_zshrcd}; do
  [[ ${_zshrcd_file:t} != '~'* ]] || continue  # ignore tilde files
  source "$_zshrcd_file"
done
unset _zshrcd{,_file}
