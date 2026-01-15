# :bookmark_tabs:  .dotfiles 

... for Bash / ZSH / Git Bash (Windows) / Cygwin (Windows) / Bash on Ubuntu on Windows

--> [Screenshots & Screencasts](https://github.com/voku/dotfiles/wiki/Images)

## :books: Documentation

- **[Technical Documentation](docs/TECHNICAL_DOCUMENTATION.md)** - Comprehensive technical guide covering architecture, design, components, and security
- **Quick Start** - See [Installation](#installation) below
- **Customization** - See [Add custom commands](#add-custom-commands-without-creating-a-new-fork)

## Requirements

- **Bash:** Version 3.2+ (with some limitations) or 4.0+ recommended for full feature support
- **ZSH:** Version 5.0+ recommended
- **Git:** Required for installation and updates
- **Optional:** rsync (for faster file copying during bootstrap)

## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
# get the code
cd ~ ; git clone https://github.com/voku/dotfiles.git; cd dotfiles

# only for Debian based e.g. Ubuntu, Lubuntu, Kubuntu etc.
./firstInstallDebianBased.sh

# only for Cygwin (Windows)
./firstInstallCygwin.sh

# copy the dotfiles into your home directory
./bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./bootstrap.sh
```

### Add custom commands without creating a new fork

If `~/.config_dotfiles` does not exists, the "bootstrap.sh"-script will create a default config for you.

My `~/.config_dotfiles` looks something like this (this is a personalized example; the default config only includes the `git` plugin for both bash and zsh):

```bash
#!/bin/sh

CONFIG_DEFAULT_USER="lars"
CONFIG_ZSH_PLUGINS="(git zsh-completions zsh-syntax-highlighting)"
CONFIG_BASH_PLUGINS="(git)"
CONFIG_ZSH_THEME="voku"
CONFIG_BASH_THEME="voku"
CONFIG_CHARSET_UTF8=true
CONFIG_LANG="en_US"
CONFIG_TERM_LOCAL="" # terms: screen byobu tmux
CONFIG_TERM_SSH=""
```

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
#!/bin/sh

export DOTFILESSRCDIR="/home/lars/dotfiles/"

GIT_AUTHOR_NAME="Lars Moelleken"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --file=$HOME/.gitconfig.extra user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL="lars@moelleken.org"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --file=$HOME/.gitconfig.extra user.email "$GIT_AUTHOR_EMAIL"

git config --file=$HOME/.gitconfig.extra push.default simple
```

You could also use `~/.extra` to override settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/voku/dotfiles/fork) instead, though. And you can use `~/.vimrc.extra` to edit the vim settings without touching the main configuration.

## :wrench: Advanced Usage

For detailed information about the architecture, components, and advanced usage patterns, see the **[Technical Documentation](docs/TECHNICAL_DOCUMENTATION.md)**.

### Run the tests

```bash
bash .redpill/tests/functions-tests.sh
zsh .redpill/tests/functions-tests.sh
```

### Key Features

- **Modular Architecture**: Separate configuration files for aliases, functions, exports, and more
- **Plugin System**: Extensible `.redpill` plugin architecture with themes and Git integration (see [Plugin Documentation](docs/PLUGINS.md))
- **Cross-Platform**: Works on Linux, macOS, Windows (Git Bash/Cygwin/WSL)
- **Safe Defaults**: Built-in safety mechanisms for file operations (e.g., `rm -I` instead of `rm`)
- **Easy Customization**: Use `.extra` and `.config_dotfiles` for personal settings without forking
- **Utility Tools**: Includes helpful scripts in `bin/` for git management, optimization, and more

### Included Utility Tools

The `bin/` directory contains useful command-line tools:

**Git Utilities:**
- `git-branch-status` - Display branch tracking information
- `git-remove-merged-branches.sh` - Clean up merged branches
- `gitstatus.sh` / `gitstatus.py` - Git status helpers
- `diff-highlight` - Enhanced diff highlighting

**Performance & Optimization:**
- `img-min.sh` - Image minification
- `browser-optimizer.sh` - Browser optimization
- `speedtest_cli.py` - Network speed testing
- `httpcompression` - HTTP compression testing

**Other Utilities:**
- `os-detect.sh` - Operating system detection
- `burl` - Browser URL launcher
- `du-ext.pl` - Disk usage by file extension
- And more...

## Feedback

Suggestions/improvements
[welcome](https://github.com/voku/dotfiles/issues)!


## Thanks to…

* [DrVanScott](https://github.com/DrVanScott/) and his [dotfiles repository](https://github.com/DrVanScott/dotfiles)
* [TuxCoder](https://github.com/TuxCoder/) and his [dotfiles repository](https://github.com/tuxcoder/dotfiles)
* [Mathias Bynens](https://github.com/mathiasbynens/) and his awesome [dotfiles repository](https://github.com/mathiasbynens/dotfiles/)
* [@ptb and his _OS X Lion Setup_ repository](https://github.com/ptb/Mac-OS-X-Lion-Setup)
* [Ben Alman](http://benalman.com/) and his [dotfiles repository](https://github.com/cowboy/dotfiles)
* [Chris Gerke](http://www.randomsquared.com/) and his [tutorial on creating an OS X SOE master image](http://chris-gerke.blogspot.com/2012/04/mac-osx-soe-master-image-day-7.html) + [_Insta_ repository](https://github.com/cgerke/Insta)
* [Cãtãlin Mariş](https://github.com/alrra) and his [dotfiles repository](https://github.com/alrra/dotfiles)
* [Gianni Chiappetta](http://gf3.ca/) for sharing his [amazing collection of dotfiles](https://github.com/gf3/dotfiles)
* [Jan Moesen](http://jan.moesen.nu/) and his [ancient `.bash_profile`](https://gist.github.com/1156154) + [shiny _tilde_ repository](https://github.com/janmoesen/tilde)
* [Lauri ‘Lri’ Ranta](http://lri.me/) for sharing [loads of hidden preferences](http://osxnotes.net/defaults.html)
* [Matijs Brinkhuis](http://hotfusion.nl/) and his [dotfiles repository](https://github.com/matijs/dotfiles)
* [Nicolas Gallagher](http://nicolasgallagher.com/) and his [dotfiles repository](https://github.com/necolas/dotfiles)
* [Sindre Sorhus](http://sindresorhus.com/)
* [Tom Ryder](http://blog.sanctum.geek.nz/) and his [dotfiles repository](https://github.com/tejr/dotfiles)
* [Kevin Suttle](http://kevinsuttle.com/) and his [dotfiles repository](https://github.com/kevinSuttle/dotfiles) and [OSXDefaults project](https://github.com/kevinSuttle/OSXDefaults)
* [Haralan Dobrev](http://hkdobrev.com/)
* anyone who [contributed a patch](https://github.com/voku/dotfiles/contributors) or [made a helpful suggestion](https://waffle.io/voku/dotfiles)
