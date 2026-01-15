# Configuration Guide

This guide explains how to configure your dotfiles installation.

## Configuration Files

### ~/.config_dotfiles

The main configuration file for your dotfiles. This file is created from `.config_dotfiles_default` during bootstrap if it doesn't exist.

**Location**: `~/.config_dotfiles`

**Variables**:

```bash
# Default username for prompt customization
CONFIG_DEFAULT_USER=""

# Enable UTF-8 character set support
CONFIG_CHARSET_UTF8=true

# Language/locale setting (en_US, de_DE, etc.)
CONFIG_LANG="en_US"

# ZSH plugins to load (space-separated list in parentheses)
CONFIG_ZSH_PLUGINS="(git zsh-completions zsh-syntax-highlighting)"

# Bash plugins to load (space-separated list in parentheses)
CONFIG_BASH_PLUGINS="(git)"

# ZSH prompt theme name
CONFIG_ZSH_THEME="voku"

# Bash prompt theme name
CONFIG_BASH_THEME="voku"

# Terminal multiplexer for local sessions (screen, byobu, or tmux)
CONFIG_TERM_LOCAL=""

# Terminal multiplexer for SSH sessions (screen, byobu, or tmux)
CONFIG_TERM_SSH=""
```

**Example Configuration**:

```bash
#!/usr/bin/env bash

CONFIG_DEFAULT_USER="john"
CONFIG_CHARSET_UTF8=true
CONFIG_LANG="en_US"
CONFIG_ZSH_PLUGINS="(git)"
CONFIG_BASH_PLUGINS="(git)"
CONFIG_ZSH_THEME="voku"
CONFIG_BASH_THEME="voku"
CONFIG_TERM_LOCAL="tmux"      # Auto-attach tmux locally
CONFIG_TERM_SSH="screen"       # Auto-attach screen over SSH
```

---

## User Customization Files

### ~/.extra

A user-specific file for custom commands, aliases, functions, and environment variables. This file is **not tracked** in the dotfiles repository.

**Purpose**:
- Add custom commands without forking the dotfiles repository
- Override default aliases and functions
- Set personal environment variables
- Configure Git user settings

**Example**:

```bash
#!/bin/sh

# Dotfiles source directory
export DOTFILESSRCDIR="$HOME/dotfiles/"

# Git user configuration
GIT_AUTHOR_NAME="John Doe"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --file=$HOME/.gitconfig.extra user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL="john.doe@example.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --file=$HOME/.gitconfig.extra user.email "$GIT_AUTHOR_EMAIL"

git config --file=$HOME/.gitconfig.extra push.default simple

# Custom aliases
alias myproject="cd ~/projects/my-awesome-project"
alias deploy="./deploy.sh"

# Custom functions
function backup() {
  tar czf ~/backup-$(date +%Y%m%d).tar.gz ~/important-files/
}

# Environment variables for development
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export MAVEN_OPTS="-Xmx2g"
export DOCKER_HOST="unix:///var/run/docker.sock"
```

---

### ~/.path

Optional file for extending the `PATH` environment variable. This file is **not tracked** in the dotfiles repository.

**Purpose**: Add custom directories to your PATH without modifying tracked files.

**Example**:

```bash
#!/bin/sh

# Add personal bin directory
export PATH="$HOME/bin:$PATH"

# Add local bin directory
export PATH="$HOME/.local/bin:$PATH"

# Add Homebrew (macOS)
export PATH="/usr/local/bin:$PATH"

# Add custom tools
export PATH="$HOME/tools/bin:$PATH"
```

---

### ~/.vimrc.extra

Custom Vim settings that extend the main `.vimrc` without modifying it.

**Purpose**: Add personal Vim configurations without affecting the tracked `.vimrc`.

**Example**:

```vim
" Custom colorscheme
colorscheme monokai

" Personal key mappings
nnoremap <leader>w :w<CR>

" Plugin configurations
let g:airline_theme='dark'
```

---

### ~/.gitconfig.extra

Personal Git configuration included by the main `.gitconfig`.

**Purpose**: Store personal Git settings separately from the shared dotfiles configuration.

**Automatically configured by ~/.extra**:

```bash
# In ~/.extra
git config --file=$HOME/.gitconfig.extra user.name "Your Name"
git config --file=$HOME/.gitconfig.extra user.email "you@example.com"
git config --file=$HOME/.gitconfig.extra push.default simple
```

---

## Platform-Specific Configuration

### Detecting Operating System

The dotfiles automatically detect the operating system and set the `SYSTEM_TYPE` variable:

- `LINUX` - Linux systems
- `OSX` - macOS
- `MINGW` - Git Bash on Windows (MSYS)
- `CYGWIN` - Cygwin on Windows
- `BSD` - BSD variants (FreeBSD, NetBSD, OpenBSD)
- `SOLARIS` - Solaris systems

**Usage in ~/.extra**:

```bash
#!/bin/sh

if [ "$SYSTEM_TYPE" = "OSX" ]; then
  # macOS-specific configuration
  export JAVA_HOME=$(/usr/libexec/java_home)
  export HOMEBREW_NO_ANALYTICS=1
  
elif [ "$SYSTEM_TYPE" = "LINUX" ]; then
  # Linux-specific configuration
  export JAVA_HOME=/usr/lib/jvm/default-java
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  
elif [ "$SYSTEM_TYPE" = "MINGW" -o "$SYSTEM_TYPE" = "CYGWIN" ]; then
  # Windows-specific configuration
  export EDITOR="notepad++"
fi
```

---

## Plugin Configuration

### Loading Plugins

Plugins are loaded from the `.redpill` directory based on the `CONFIG_BASH_PLUGINS` or `CONFIG_ZSH_PLUGINS` variables.

**Available Plugin Locations**:
- `~/.redpill/plugins/available/` - Available plugins
- `~/.redpill/aliases/available/` - Plugin-specific aliases
- `~/.redpill/completion/available/` - Plugin-specific completions

**Configuration in ~/.config_dotfiles**:

```bash
# Load multiple plugins
CONFIG_BASH_PLUGINS="(git z wd)"

# Load only git plugin (minimal)
CONFIG_BASH_PLUGINS="(git)"
```

### Custom Plugins

Create custom plugins without modifying the dotfiles repository:

**Location**: `~/.redpill/plugins/custom.plugins.bash`

**Example**:

```bash
#!/usr/bin/env bash

# Custom plugin functionality
function mycommand() {
  echo "Running custom command"
  # command logic here
}

# Custom completions
_mycommand_completion() {
  COMPREPLY=($(compgen -W "option1 option2 option3" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _mycommand_completion mycommand
```

---

## Terminal Multiplexer Configuration

### Auto-Attach Configuration

Configure automatic attachment to terminal multiplexers (screen, byobu, or tmux) based on connection type.

**In ~/.config_dotfiles**:

```bash
# Auto-attach tmux for local terminals
CONFIG_TERM_LOCAL="tmux"

# Auto-attach screen for SSH sessions
CONFIG_TERM_SSH="screen"

# Disable auto-attach (leave empty)
CONFIG_TERM_LOCAL=""
CONFIG_TERM_SSH=""
```

**Behavior**:
- If not already in a session, automatically attach to existing detached session or create new one
- Local vs SSH detection based on `$SSH_TTY` variable
- Configured in `~/.shellrc` (sourced by `.zshrc`)

---

## Editor Configuration

### Setting Default Editor

The dotfiles automatically detect and set the default editor:

1. If SSH connection: use `vim`
2. If `subl` (Sublime Text) is available: use `subl`
3. Otherwise: use `vim`

**Override in ~/.extra**:

```bash
# Force specific editor
export EDITOR="code"  # Visual Studio Code
export VISUAL="$EDITOR"

# Or use nano
export EDITOR="nano"
export VISUAL="$EDITOR"
```

---

## Best Practices

### 1. Use ~/.extra for Personal Settings

✅ **Do**:
- Store personal information in `~/.extra`
- Override aliases and functions
- Add custom environment variables

❌ **Don't**:
- Modify tracked dotfiles directly
- Store passwords or secrets in plain text
- Commit `~/.extra` to any repository

### 2. Keep ~/.config_dotfiles Minimal

✅ **Do**:
- Only change settings you need to customize
- Keep plugins list short for faster startup
- Document your changes with comments

❌ **Don't**:
- Enable unnecessary plugins
- Use complex logic (keep it simple variable assignments)

### 3. Use ~/.path for PATH Extensions

✅ **Do**:
- Add custom directories to PATH in `~/.path`
- Keep PATH modifications in one place
- Check if directories exist before adding

❌ **Don't**:
- Duplicate PATH entries
- Add system directories already in PATH

### 4. Protect Sensitive Files

```bash
# Set restrictive permissions
chmod 600 ~/.extra
chmod 600 ~/.gitconfig.extra
chmod 600 ~/.config_dotfiles
```

---

## Troubleshooting

### Configuration Not Loading

**Check file permissions**:
```bash
ls -la ~/.config_dotfiles ~/.extra ~/.path
```

Files must be readable (`-r` permission).

**Check for syntax errors**:
```bash
bash -n ~/.extra  # Check syntax without executing
```

### Plugins Not Loading

**Verify plugin configuration**:
```bash
echo $CONFIG_BASH_PLUGINS
```

**Check if .redpill exists**:
```bash
ls -la ~/.redpill
```

**Verify plugin files**:
```bash
ls -la ~/.redpill/plugins/available/
```

### Terminal Multiplexer Not Auto-Attaching

**Check configuration**:
```bash
source ~/.config_dotfiles
echo "Local: $CONFIG_TERM_LOCAL"
echo "SSH: $CONFIG_TERM_SSH"
```

**Verify multiplexer is installed**:
```bash
which tmux
which screen
which byobu
```

---

## See Also

- [Technical Documentation](TECHNICAL_DOCUMENTATION.md) - Complete architecture and component reference
- [README.md](../README.md) - Quick start and installation guide
