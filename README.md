# zshrc.d

[![License](https://img.shields.io/badge/license-MIT-007EC7)](/LICENSE)
[![built for](https://img.shields.io/badge/built%20for-%20%F0%9F%A6%93%20zshzoo-black)][zshzoo]
[![works with prezto](https://img.shields.io/badge/works%20with-%E2%9D%AF%E2%9D%AF%E2%9D%AF%20prezto-red)](#install-for-prezto)
[![works with ohmyzsh](https://img.shields.io/badge/works%20with-%20%E2%9E%9C%20oh--my--zsh-C2D33F)](#install-for-oh-my-zsh)

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

### Install with a Zsh plugin manager

To install using a Zsh plugin manager, add the following to your .zshrc

- [antidote]: `antidote bundle zshzoo/zshrc.d`
- [zcomet]: `zcomet load zshzoo/zshrc.d`
- [zgenom]: `zgenom load zshzoo/zshrc.d`
- [znap]: `znap source zshzoo/zshrc.d`

### Install manually, without a plugin manager

To install manually, first clone the repo:

```zsh
git clone https://github.com/zshzoo/zshrc.d ${ZDOTDIR:-~}/.zplugins/zshrc.d
```

Then, in your .zshrc, add the following line:

```zsh
source ${ZDOTDIR:-~}/.zplugins/zshrc.d/zshrc.d.zsh
```

### Install for Oh-My-Zsh

To install with [Oh-My-Zsh][ohmyzsh], first clone the repo from an interactive Zsh session:

```zsh
# make sure your $ZSH_CUSTOM is set
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# now, clone the plugin
git clone https://github.com/zshzoo/zshrc.d $ZSH_CUSTOM/plugins/zshrc.d
```

Then, add the plugin to your Oh-My-Zsh plugins list in your .zshrc

```zsh
# in your .zshrc, add this plugin to your plugins list
plugins=(... zshrc.d)
```

### Install for Prezto

To install with [Prezto][prezto], first clone the repo from an interactive Zsh session:

```zsh
# make sure your $ZPREZTODIR is set
ZPREZTODIR=${ZPREZTODIR:-~/.zprezto}
# clone the repo to a prezto contrib dir
git clone https://github.com/zshzoo/zshrc.d $ZPREZTODIR/contrib/zshrc.d/external
# set up the contrib
echo "source \${0:A:h}/external/zshrc.d.plugin.zsh" > $ZPREZTODIR/contrib/zshrc.d/init.zsh
```

Then, add the plugin to your Prezto plugins list in .zpreztorc

```zsh
zstyle ':prezto:load' pmodule \
  ... \
  zshrc.d \
  ...
```

[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
[zshzoo]: https://github.com/zshzoo/zshzoo
[antidote]: https://github.com/mattmc3/antidote
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
