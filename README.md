# zshrc.d

> Load ZSH config files from a zshrc.d directory

## Description

This plugin allows you to source your .zshrc configuration from files in a directory.

So, instead of storing all your configuration settings in a single `~/.zshrc` file,
you can organize `.zsh` files in a `${ZDOTDIR:-$HOME}/.zshrc.d` directory and this
plugin will source them.

If using `$ZDOTDIR`, this plugin supports using the non-hidden `$ZDOTDIR/zshrc.d`
directory as an alternative, or you can set the `$ZSHRCD` to specify a custom
location.

## FAQ

_Q: Does this mean I can replace my `.zshrc` file entirely?_

**A: No, you will still need a `.zshrc` file for Zsh to run properly, but you can
reduce its contents to just the minimal code required to load this plugin and then use
your `.zshrc.d` directory for everything else.**

_Q: How can I ensure that my .zsh config files are loaded in the right order?_

**A: Files are sorted alphabetically by locale, the same as your `ls` command, so name
your files accordingly.**

_Q: How do I name files if I need them to load first?_

**A: One method is to prefix any files that have to load first with a numbering scheme
(ie: 00-99).**

_Q: How do I name files if I need them to load last?_

**A: One method is to prefix any files that have to load last with `zz-`, or `zz01-`.**

_Q: How do I keep a file in my zshrc.d directory, but prevent it from being sourced?_

**A: Files prefixed with a tilde (~) are skipped by this plugin.**

## Customizing

If you want to use an alternate path, add set the `$ZSHRCD` variable prior to sourcing
this plugin:

```zsh
ZSHRCD=~/path/to/my/custom/zshrc.d
```

## Installation

To install using a modern Zsh plugin manager, add the following to your .zshrc

- [pz]: `pz source mattmc3/zshrc.d`
- [znap]: `znap source mattmc3/zshrc.d`
- [zgenom]: `zgenom load mattmc3/zshrc.d`

To install manually, without a plugin manager, add the following to your .zshrc:

```zsh
ZSH_PLUGIN_DIR=${HOME:-ZDOTDIR}/.zsh_plugins
[[ -f $ZSH_PLUGIN_DIR/zshrc.d/zshrc.d.plugin.zsh ]] ||
    git clone https://github.com/mattmc3/zshrc.d $ZSH_PLUGIN_DIR/zshrc.d
source $ZSH_PLUGIN_DIR/zshrc.d/zshrc.d.plugin.zsh
```

To install with [Oh-My-Zsh][omz]:

```zsh
# from your interactive Zsh session, clone the repo
git clone https://github.com/mattmc3/zshrc.d $ZSH_CUSTOM/plugins/zshrc.d

# in your .zshrc, add this plugin to your plugins list
plugins=(... zshrc.d)
```

To install using a legacy Zsh plugin manager, add the following to your .zshrc:

- [antibody]: `antibody bundle mattmc3/zshrc.d`
- [zgen]: `zgen load mattmc3/zshrc.d`
- [antigen]: `antigen bundle mattmc3/zshrc.d@main`

[pz]: https://github.com/mattmc3/pz
[antigen]: https://github.com/zsh-users/antigen
[antibody]: https://getantibody.github.io
[znap]: https://github.com/marlonrichert/zsh-snap
[zgen]: https://github.com/tarjoilija/zgen
[zgenom]: https://github.com/jandamm/zgenom
[omz]: https://github.com/ohmyzsh/ohmyzsh
