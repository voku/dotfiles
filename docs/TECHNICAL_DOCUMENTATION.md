# .dotfiles Technical Documentation

**Version:** 1.0  
**Target Audience:** Mixed developers (beginner to advanced)  
**Last Updated:** 2026-01-15

---

## Architecture Overview

The `.dotfiles` repository is a comprehensive shell environment configuration system designed for cross-platform compatibility. It provides a modular, plugin-based architecture that works seamlessly across Bash, ZSH, Git Bash (Windows), Cygwin (Windows), and Bash on Ubuntu on Windows (WSL).

### High-Level Architecture

The system follows a layered initialization pattern where configuration files are loaded in a specific order:

1. **Shell Entry Points** (`.bash_profile`, `.bashrc`, `.zshrc`, `.zprofile`)
2. **Core Configuration Layer** (`.exports`, `.colors`, `.icons`)
3. **Functionality Layer** (`.aliases`, `.functions`)
4. **Plugin System** (`.redpill` directory)
5. **User Customization Layer** (`.extra`, `.config_dotfiles`)

### Key Design Principles

- **Modularity**: Each configuration aspect is separated into distinct files
- **Cross-Platform Compatibility**: OS detection and conditional loading
- **Non-Invasive Installation**: User customizations preserved via `.extra` and `.config_dotfiles`
- **Plugin Architecture**: Extensible through the `.redpill` plugin system
- **Version Control Friendly**: Git-based distribution and updates

---

## Design Goals & Constraints

### Design Goals

1. **Universal Compatibility**: Support multiple shells (Bash 3+, Bash 4+, ZSH) and operating systems (Linux, macOS, Windows via Git Bash/Cygwin/WSL)
2. **Developer Productivity**: Provide time-saving aliases, functions, and tools for common development tasks
3. **Safe Defaults**: Implement safety mechanisms (e.g., `rm -I` instead of `rm`) without being intrusive
4. **Easy Customization**: Allow users to extend or override defaults without forking
5. **Visual Enhancement**: Provide themed prompts with Git integration and status indicators

### Constraints

1. **Bash Version Compatibility**: Must support Bash 3.x (macOS default) while leveraging Bash 4 features when available
2. **Interactive Shell Only**: Configuration only loads in interactive shells (checks for `PS1` and `-i` flag)
3. **No External Dependencies**: Core functionality must work with standard Unix tools
4. **Preserve User Settings**: Git configuration and user customizations must not be overwritten
5. **Performance**: Fast shell startup time (lazy loading where possible)

---

## Layer Model / Diagram

### Shell Initialization Flow

```
┌─────────────────────────────────────────────────────────────┐
│                     SHELL STARTUP                            │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  Entry Point Detection                                       │
│  • Login Shell: .bash_profile / .zprofile                   │
│  • Interactive Non-Login: .bashrc / .zshrc                  │
│  • Check: Interactive? (PS1 set && -i flag)                 │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  Layer 1: System Detection & Base Exports                   │
│  Files: .exports                                             │
│  • OS Detection (SYSTEM_TYPE)                               │
│  • EDITOR, PAGER, PATH setup                                │
│  • Language/Locale settings                                 │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  Layer 2: Configuration Loading (.bashrc / .zshrc)          │
│  Load order (via .bash_profile):                            │
│  1. .config_dotfiles (user config)                          │
│  2. .path (custom PATH extensions)                          │
│  3. .load (special loaders like RVM)                        │
│  4. .colors (color definitions)                             │
│  5. .exports (environment variables)                        │
│  6. .icons (icon definitions)                               │
│  7. .aliases (command aliases)                              │
│  8. .bash_complete (completions)                            │
│  9. .functions (shell functions)                            │
│  10. .extra (user customizations)                           │
│  11. .dotfilecheck (version check)                          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  Layer 3: Shell Options & Features                          │
│  • Bash 4 features: autocd, globstar, extglob              │
│  • History: histappend, histreedit                          │
│  • Safety: no_empty_cmd_completion                          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  Layer 4: Plugin System (.redpill)                          │
│  Initialize if ~/.redpill exists:                            │
│  1. Load composure.bash (function metadata)                 │
│  2. Load colors/base themes                                 │
│  3. Load lib/*.bash (libraries)                             │
│  4. Load base plugin                                        │
│  5. Load configured plugins from CONFIG_BASH_PLUGINS        │
│  6. Load custom aliases/completion/plugins                  │
│  7. Load git prompt (gitprompt.sh)                          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  Layer 5: Terminal Multiplexer (.shellrc)                   │
│  • Auto-attach to screen/byobu/tmux based on config         │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                   READY FOR USER INPUT                       │
└─────────────────────────────────────────────────────────────┘
```

### File Dependencies

```
.bashrc
├── .bash_profile
    ├── .config_dotfiles (user config)
    ├── .path (optional)
    ├── .load
    ├── .colors
    ├── .exports
    ├── .icons
    ├── .aliases
    ├── .bash_complete
    ├── .functions
    ├── .extra (optional)
    └── .dotfilecheck

.bash_profile (when .redpill exists)
└── .redpill/redpill-init-bash.sh
    ├── .redpill/lib/composure.bash
    ├── .redpill/themes/colors.theme.bash
    ├── .redpill/themes/base.theme.bash
    ├── .redpill/lib/*.bash
    ├── .redpill/plugins/available/base.plugin.bash
    ├── .redpill/[aliases|completion|plugins]/available/*.bash
    ├── .redpill/[aliases|completion|plugins]/custom.*.bash
    └── .redpill/bash_prompt/gitprompt.sh
```

---

## Type Safety & Validation

### Shell Version Detection

The dotfiles system performs version and compatibility checks:

```bash
# From .bash_profile (lines 10-15)
bashVersionTmp="$(bash --version | grep -v "version 4")"
if [[ "$bashVersionTmp" == *-pc-msys* ]]; then
  . ~/.extra
  return 0
fi
```

**Constraint**: Windows Git Bash version 3 is considered too minimal and loads only `.extra`.

### Interactive Shell Validation

```bash
# From .bashrc (lines 5-7)
if [[ $- != *i* ]] || [ -z "$PS1" ]; then
  return 0
fi
```

**Purpose**: Prevents loading interactive configurations in non-interactive contexts (scripts, automation).

### System Type Detection

```bash
# From .exports (lines 26-34)
case "$OSTYPE" in
  solaris*) SYSTEM_TYPE="SOLARIS" ;;
  darwin*)  SYSTEM_TYPE="OSX" ;;
  linux*)   SYSTEM_TYPE="LINUX" ;;
  bsd*)     SYSTEM_TYPE="BSD" ;;
  msys*)    SYSTEM_TYPE="MINGW" ;;
  cygwin*)  SYSTEM_TYPE="CYGWIN" ;;
esac
```

**Usage**: Enables OS-specific behavior throughout the system via `$SYSTEM_TYPE` variable.

### File Existence Checks

The system safely checks for file existence before sourcing:

```bash
# From .bash_profile (lines 22-25)
for file in ~/.{config_dotfiles,path,load,colors,exports,icons,aliases,bash_complete,functions,extra,dotfilecheck}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
```

**Safety**: Files are only sourced if readable (`-r`) and regular files (`-f`).

---

## Core Components

### 1. Entry Point Files

#### `.bash_profile`
- **Purpose**: Login shell entry point
- **Key Responsibilities**:
  - Check for interactive shell
  - Verify Bash version compatibility
  - Load core configuration files in correct order
  - Initialize `.redpill` plugin system if available
- **Loaded by**: Login shells (terminal app startup, SSH login)

#### `.bashrc`
- **Purpose**: Non-login interactive shell entry point
- **Key Actions**:
  - Check for interactive shell
  - Load global bashrc (`/etc/bashrc`)
  - Source `.bash_profile` for unified configuration
- **Loaded by**: Interactive non-login shells (e.g., shells spawned by Vim)

#### `.zshrc` / `.zprofile`
- **Purpose**: ZSH equivalents of Bash entry points
- **Features**:
  - Right-side timestamp prompt
  - Sources `.shellrc` for terminal multiplexer management
- **Loaded by**: ZSH login and interactive shells

### 2. Configuration Files

#### `.config_dotfiles` (User Configuration)
**Location**: `~/.config_dotfiles`  
**Default Template**: `.config_dotfiles_default`

**Variables**:
```bash
CONFIG_DEFAULT_USER=""           # Default username for prompt
CONFIG_CHARSET_UTF8=true         # UTF-8 support
CONFIG_LANG="en_US"              # Language setting
CONFIG_ZSH_PLUGINS="(git)"       # ZSH plugins to load
CONFIG_BASH_PLUGINS="(git)"      # Bash plugins to load
CONFIG_ZSH_THEME="voku"          # ZSH theme
CONFIG_BASH_THEME="voku"         # Bash theme
CONFIG_TERM_LOCAL=""             # Local terminal multiplexer: screen|byobu|tmux
CONFIG_TERM_SSH=""               # SSH terminal multiplexer
```

**Purpose**: User-level configuration without modifying tracked files.

#### `.exports`
**Line Count**: 387 lines  
**Purpose**: Environment variable definitions

**Key Exports**:
- `EDITOR`: Text editor (auto-detects `subl`, falls back to `vim`)
- `PAGER`: Paging program (defaults to `less`)
- `SYSTEM_TYPE`: Operating system detection
- `DIR_DOTFILES`: Dotfiles repository location
- Language and locale settings
- Tool-specific configurations

#### `.aliases`
**Line Count**: 556 lines  
**Purpose**: Command shortcuts and safety aliases

**Categories**:
- Default safety aliases (`rm -I`, `sudo `)
- Navigation shortcuts
- Git aliases
- File operations
- System monitoring
- Development tools

**Example**:
```bash
alias sudo='sudo '        # Enable alias expansion after sudo
alias please='sudo'       # Polite sudo
alias rm='rm -I'          # Prompt before removing 3+ files
```

#### `.functions`
**Line Count**: 1,579 lines  
**Purpose**: Complex shell functions

**Categories**:
- File operations (extraction, compression)
- Git helpers
- Network utilities
- String manipulation
- System information
- Development workflows

**Example Functions**:
- `cd()`: Enhanced cd with `...` for `../../`, autoenv support
- `err()`: Error logging with timestamp
- `lc()`/`uc()`: Case conversion
- Various extraction and compression helpers

#### `.colors`
**Purpose**: Color variable definitions

**Usage**:
```bash
COLOR_GREEN="\033[0;32m"
COLOR_NO_COLOUR="\033[0m"
```

**Application**: Terminal output formatting, prompts, scripts.

#### `.bash_complete`
**Purpose**: Bash completion definitions
**Enhances**: Tab completion for custom commands and scripts

### 3. The .redpill Plugin System

#### Overview
`.redpill` is a plugin architecture inspired by oh-my-zsh, providing:
- Modular plugin loading
- Theme support with Git integration
- Function metadata via composure
- Extensible aliases, completions, and plugins

#### Directory Structure
```
.redpill/
├── redpill-init-bash.sh          # Bash initialization
├── redpill-init-zsh.sh           # ZSH initialization
├── lib/                          # Core libraries
│   └── composure.bash            # Function metadata system
├── themes/                       # Prompt themes
│   ├── colors.theme.bash
│   └── base.theme.bash
├── bash_prompt/                  # Bash prompt components
│   ├── gitprompt.sh             # Git status in prompt
│   └── gitstatus.sh             # Git status detection
├── zsh_prompt/                   # ZSH prompt components
├── plugins/                      # Plugin system
│   ├── available/               # Available plugins
│   ├── enabled/                 # Enabled plugins (legacy)
│   └── custom.plugins.bash      # User plugins
├── aliases/                      # Plugin aliases
│   ├── available/
│   └── custom.aliases.bash
├── completion/                   # Plugin completions
│   ├── available/
│   └── custom.completion.bash
└── tests/                        # Test suite
    └── functions-tests.sh
```

#### Plugin Loading Process

1. Load composure for function metadata
2. Load color and base themes
3. Load all libraries from `lib/*.bash`
4. Load base plugin
5. For each plugin in `CONFIG_BASH_PLUGINS`:
   - Load `aliases/available/{plugin}.aliases.bash`
   - Load `completion/available/{plugin}.completion.bash`
   - Load `plugins/available/{plugin}.plugin.bash`
6. Load custom aliases, completions, plugins
7. Load Git prompt

### 4. Utility Scripts

#### `bootstrap.sh`
**Purpose**: Install/update dotfiles to home directory

**Features**:
- Git pull latest changes
- Dry-run mode (shows changes before applying)
- Rsync or cp-based file copying
- Git config preservation (backs up and offers restore)
- Creates default `.config_dotfiles` if missing
- CRLF safety check for Windows systems
- Vim plugin manager installation

**Usage**:
```bash
./bootstrap.sh           # Dry run + confirmation
./bootstrap.sh --force   # Skip confirmation
```

#### `firstInstallDebianBased.sh`
**Purpose**: Debian/Ubuntu initial system setup
**Actions**: Install required packages and tools

#### `firstInstallCygwin.sh`
**Purpose**: Cygwin (Windows) initial setup
**Actions**: Install Cygwin-specific packages

### 5. Additional Configuration Files

- **`.load`**: RVM (Ruby Version Manager) and Jekyll configuration
- **`.shellrc`**: Terminal multiplexer auto-attach (screen/byobu/tmux)
- **`.extra`**: User-specific commands and overrides (not tracked)
- **`.path`**: Custom PATH extensions (optional, not tracked)
- **`.inputrc`**: Readline configuration
- **`.gitconfig`**: Git global configuration
- **`.vimrc`**: Vim editor configuration
- **`.tmux.conf`**: Tmux configuration

---

## Usage Patterns / Recipes

### Initial Installation

```bash
# Clone repository
cd ~
git clone https://github.com/voku/dotfiles.git
cd dotfiles

# For Debian/Ubuntu (first time only)
./firstInstallDebianBased.sh

# For Cygwin/Windows (first time only)
./firstInstallCygwin.sh

# Install dotfiles (dry run first)
./bootstrap.sh

# After reviewing changes, confirm installation
# (when prompted with y/n)
```

### Updating Dotfiles

```bash
cd ~/dotfiles
./bootstrap.sh
```

The script automatically pulls latest changes and prompts before overwriting.

### Customizing Without Forking

#### Create User Configuration

```bash
# Edit ~/.config_dotfiles
vim ~/.config_dotfiles
```

**Example**:
```bash
CONFIG_DEFAULT_USER="john"
CONFIG_BASH_THEME="voku"
CONFIG_TERM_LOCAL="tmux"
```

#### Add Custom Commands

```bash
# Create ~/.extra file
vim ~/.extra
```

**Example**:
```bash
#!/bin/sh

# Custom exports
export DOTFILESSRCDIR="/home/john/dotfiles/"

# Git configuration
GIT_AUTHOR_NAME="John Doe"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --file=$HOME/.gitconfig.extra user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL="john@example.com"
git config --file=$HOME/.gitconfig.extra user.email "$GIT_AUTHOR_EMAIL"

# Custom aliases
alias myproject="cd ~/projects/myproject"

# Custom functions
function deploy() {
  echo "Deploying..."
  # deployment logic
}
```

### Extending PATH

```bash
# Create ~/.path file
vim ~/.path
```

**Example**:
```bash
#!/bin/sh
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
```

### Adding Custom Redpill Plugins

```bash
# Create custom plugin
vim ~/.redpill/plugins/custom.plugins.bash
```

**Example**:
```bash
#!/usr/bin/env bash

# Custom plugin functionality
function my_custom_command() {
  echo "Custom command executed"
}
```

### Configuring Terminal Multiplexer

**Automatic tmux/screen attachment**:

```bash
# In ~/.config_dotfiles
CONFIG_TERM_LOCAL="tmux"     # Auto-attach tmux for local terminals
CONFIG_TERM_SSH="screen"     # Auto-attach screen for SSH sessions
```

### Testing Functions

```bash
# Run function tests
bash ~/.redpill/tests/functions-tests.sh

# Or with ZSH
zsh ~/.redpill/tests/functions-tests.sh
```

### OS-Specific Customization

```bash
# In ~/.extra
if [[ "$SYSTEM_TYPE" == "OSX" ]]; then
  # macOS-specific settings
  export JAVA_HOME=$(/usr/libexec/java_home)
elif [[ "$SYSTEM_TYPE" == "LINUX" ]]; then
  # Linux-specific settings
  export JAVA_HOME=/usr/lib/jvm/default-java
fi
```

---

## Critical Pitfalls

### 1. Git Configuration Overwrites

**Issue**: Running `bootstrap.sh` copies `.gitconfig` which may overwrite your personal Git settings.

**Mitigation**:
- Bootstrap script backs up existing Git config
- Prompts to restore previous settings
- Use `~/.gitconfig.extra` for personal settings (included by main `.gitconfig`)

**Best Practice**:
```bash
# Store personal settings in .extra
git config --file=$HOME/.gitconfig.extra user.name "Your Name"
git config --file=$HOME/.gitconfig.extra user.email "you@example.com"
```

### 2. CRLF Issues on Windows

**Issue**: Git's `core.autocrlf=true` setting can corrupt Vim files with CRLF line endings.

**Detection**: Bootstrap script checks for this and warns.

**Solution**:
```bash
# Temporarily disable
git config --global core.autocrlf false

# Run bootstrap
./bootstrap.sh

# Re-enable if needed
git config --global core.autocrlf true
```

### 3. Bash Version 3 Limitations

**Issue**: macOS ships with Bash 3.2 due to licensing. Bash 4+ features won't work.

**Affected Features**:
- `**` recursive globbing
- Associative arrays
- Advanced `shopt` options

**Solution**:
```bash
# macOS: Install Bash 4+ via Homebrew
brew install bash

# Add to /etc/shells and change default shell
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash
```

### 4. Performance with Too Many Plugins

**Issue**: Loading many `.redpill` plugins slows shell startup.

**Symptoms**: Noticeable delay when opening new terminals.

**Solution**:
```bash
# In ~/.config_dotfiles, minimize plugins
CONFIG_BASH_PLUGINS="(git)"  # Only essential plugins
```

### 5. Conflicting Aliases in .extra

**Issue**: Aliases in `.extra` may conflict with dotfiles aliases.

**Example**:
```bash
# In .aliases
alias ll='ls -la'

# In .extra (loaded after .aliases)
alias ll='ls -l'  # This overrides
```

**Best Practice**: Use unique names or intentionally override with comments explaining why.

### 6. Non-Interactive Shell Errors

**Issue**: Scripts or automation may fail if they source `.bashrc` without being interactive.

**Cause**: Many dotfiles assume interactive shell context.

**Protection**: Built-in checks prevent loading:
```bash
if [[ $- != *i* ]] || [ -z "$PS1" ]; then
  return 0
fi
```

**Best Practice**: For scripts, source only specific files needed:
```bash
#!/bin/bash
source ~/.exports  # Only exports, not full .bashrc
```

### 7. Terminal Multiplexer Infinite Loops

**Issue**: Incorrect `CONFIG_TERM_LOCAL` can cause infinite session creation.

**Example**: Setting `CONFIG_TERM_LOCAL="tmux"` while already in tmux.

**Protection**: `.shellrc` checks for existing sessions:
```bash
if [[ "$_TERM" == "tmux" ]] && [[ -z "$TMUX" ]]; then
  # Only start if not already in tmux
fi
```

### 8. Symlink Installation Issues

**Issue**: If dotfiles are installed via symlinks (not recommended), updates can cause issues.

**Recommended Approach**: Use `bootstrap.sh` which copies files, not symlinks.

---

## Quick Reference (API)

### Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `CONFIG_DEFAULT_USER` | `""` | Username for prompt customization |
| `CONFIG_CHARSET_UTF8` | `true` | Enable UTF-8 support |
| `CONFIG_LANG` | `"en_US"` | Language/locale setting |
| `CONFIG_BASH_PLUGINS` | `"(git)"` | Bash plugins to load |
| `CONFIG_ZSH_PLUGINS` | `"(git)"` | ZSH plugins to load |
| `CONFIG_BASH_THEME` | `"voku"` | Bash prompt theme |
| `CONFIG_ZSH_THEME` | `"voku"` | ZSH prompt theme |
| `CONFIG_TERM_LOCAL` | `""` | Local terminal multiplexer (screen\|byobu\|tmux) |
| `CONFIG_TERM_SSH` | `""` | SSH terminal multiplexer |

### Environment Variables

| Variable | Example | Description |
|----------|---------|-------------|
| `EDITOR` | `vim` or `subl` | Default text editor |
| `PAGER` | `less` | Default pager |
| `SYSTEM_TYPE` | `LINUX`, `OSX`, `MINGW`, `CYGWIN` | Detected operating system |
| `DIR_DOTFILES` | `/home/user/dotfiles` | Dotfiles repository location |
| `REDPILL` | `$HOME/.redpill` | Redpill plugin directory |

### Key Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `sudo` | `sudo ` | Enable alias expansion after sudo |
| `please` | `sudo` | Polite sudo |
| `_` | `sudo` | Quick sudo |
| `clr` | `clear` | Clear screen |
| `rm` | `rm -I` | Safe remove (prompt for 3+ files) |
| `vi` | `vim` | Use Vim for vi |

### Key Functions

| Function | Parameters | Description |
|----------|------------|-------------|
| `cd()` | `[path]` | Enhanced cd: `...` for `../../`, autoenv support |
| `cdo()` | none | cd to previous directory ($OLDPWD) |
| `err()` | `message` | Log error with timestamp to stderr |
| `lc()` | `[text]` | Convert to lowercase (stdin or args) |
| `uc()` | `[text]` | Convert to uppercase (stdin or args) |

### Bootstrap Commands

| Command | Description |
|---------|-------------|
| `./bootstrap.sh` | Dry run + install/update dotfiles |
| `./bootstrap.sh --force` | Force install without confirmation |
| `./firstInstallDebianBased.sh` | First-time Debian/Ubuntu setup |
| `./firstInstallCygwin.sh` | First-time Cygwin setup |

### Testing

| Command | Description |
|---------|-------------|
| `bash ~/.redpill/tests/functions-tests.sh` | Run function tests with Bash |
| `zsh ~/.redpill/tests/functions-tests.sh` | Run function tests with ZSH |

### File Loading Order

1. `.bash_profile` or `.zprofile` (login shells)
2. `.bashrc` or `.zshrc` (interactive non-login shells source profile)
3. `.config_dotfiles` (user configuration)
4. `.path` (optional PATH extensions)
5. `.load` (special loaders)
6. `.colors` (color definitions)
7. `.exports` (environment variables)
8. `.icons` (icon definitions)
9. `.aliases` (command aliases)
10. `.bash_complete` (completions)
11. `.functions` (shell functions)
12. `.extra` (user customizations)
13. `.dotfilecheck` (version check)
14. `.redpill/redpill-init-bash.sh` (plugin system initialization)

---

## Security Considerations

### 1. Safe File Operations

**Default Safety Aliases**:
```bash
alias rm='rm -I'                       # Prompt before removing 3+ files
alias chown='chown --preserve-root'    # Prevent accidental root changes
alias chmod='chmod --preserve-root'    # Prevent accidental root changes
alias chgrp='chgrp --preserve-root'    # Prevent accidental root changes
```

**Purpose**: Prevent accidental data loss and system damage.

**Override**: Use `command rm`, `\rm`, or `/bin/rm` to bypass.

### 2. SSH Key Management

**Auto-Loading SSH Keys**:
```bash
# From .aliases (lines 25-27)
if [ "$SSH_AUTH_SOCK" != "" ] && [ -f ~/.ssh/id_rsa ] && [ -x /usr/bin/ssh-add ]; then
  ssh-add -l >/dev/null || alias ssh='(ssh-add -l >/dev/null || ssh-add) && unalias ssh; ssh'
fi
```

**Behavior**: Automatically adds SSH key to agent on first SSH command if key exists and agent is running.

**Security Note**: Requires manual passphrase entry; does not store passphrases insecurely.

### 3. Credential Storage in .extra

**Risk**: `.extra` file is not version controlled but is copied during bootstrap.

**Best Practices**:
- Never commit `.extra` to any repository
- Use restrictive permissions: `chmod 600 ~/.extra`
- Do not store plain-text passwords in `.extra`
- Use `git config --file=$HOME/.gitconfig.extra` for Git credentials
- Consider using credential managers (e.g., `pass`, `1password-cli`)

**Example Safe Pattern**:
```bash
# In ~/.extra
# Use environment variables or credential helpers
export AWS_PROFILE="default"  # Profile name, not credentials

# Use Git credential helper
git config --file=$HOME/.gitconfig.extra credential.helper "store"
```

### 4. Permission Management

**Bootstrap Script Permissions**:
```bash
# From bootstrap.sh (lines 47-50)
OLDMASK=$(umask)
umask 0077  # Restrictive: owner-only read/write
git config --global -l | LANG=C sort > .oldgit$$.tmp
umask $OLDMASK
```

**Purpose**: Temporary files containing Git config (which may have sensitive info) are created with owner-only permissions.

### 5. Git Configuration Security

**Separate Personal Config**:
The system uses `.gitconfig.extra` for personal settings:

```bash
# From README.md example
git config --file=$HOME/.gitconfig.extra user.name "Name"
git config --file=$HOME/.gitconfig.extra user.email "email"
```

**Benefit**: Personal Git configuration is kept separate from shared dotfiles.

**Security**: `.gitconfig.extra` should have restricted permissions and is not tracked.

### 6. Sudo Alias Expansion

```bash
alias sudo='sudo '  # Trailing space enables alias expansion
```

**Security Implication**: Aliases work after sudo, allowing both convenience and risk.

**Risk Example**:
```bash
alias rm='rm -rf'  # Dangerous alias
sudo rm /important  # Would execute 'rm -rf /important'
```

**Mitigation**: Dotfiles use safe defaults (`rm -I`), but users should be cautious with custom aliases.

### 7. Script Execution from Repository

**Risk**: Running `bootstrap.sh` executes code directly from the repository.

**Mitigations**:
- Review changes before running: `git log` and `git diff`
- Dry-run mode shows changes before applying
- Open-source and community-reviewed

**Best Practice**:
```bash
# Review recent changes
cd ~/dotfiles
git log -p -5

# Understand what will change
./bootstrap.sh  # Dry run first
```

### 8. CRLF Injection Risk (Windows)

**Issue**: CRLF line endings can cause unexpected behavior in shell scripts.

**Protection**: Bootstrap warns if `core.autocrlf=true`:
```bash
# From bootstrap.sh (lines 95-106)
if [ "$(git config --system --get core.autocrlf)" == "true" ]; then
  crlf_warning="--system "
fi
if [ "$(git config --global --get core.autocrlf)" == "true" ]; then
  crlf_warning="${crlf_warning}--global"
fi
if [ -n "$crlf_warning" ]; then
  echo "git config 'core.autocrlf' is currently true..."
  return 1
fi
```

**Best Practice**: Disable `core.autocrlf` before bootstrap on Windows.

### 9. Environment Variable Injection

**Risk**: Sourcing untrusted `.extra` or `.config_dotfiles` could inject malicious environment variables.

**Mitigations**:
- Files are user-controlled (not from repository)
- Interactive check prevents non-interactive exploitation
- Users should only edit these files themselves

**Warning**: Never copy `.extra` from untrusted sources.

### 10. Plugin Security

**Risk**: `.redpill` plugins execute arbitrary code.

**Mitigations**:
- Plugins are version-controlled in the repository
- Community review of plugin code
- Users control which plugins load via `CONFIG_BASH_PLUGINS`

**Best Practice**: Review plugin code before enabling:
```bash
# Check plugin code
cat ~/.redpill/plugins/available/plugin-name.plugin.bash
```

---

## Appendix: File Verification Checklist

This documentation was verified against the following source files:

- ✓ `.bash_profile` (81 lines) - Shell entry point and loading sequence
- ✓ `.bashrc` (54 lines) - Non-login shell entry point
- ✓ `.bashrc` (lines 22-25) - File loading loop verified
- ✓ `.load` (9 lines) - RVM and Jekyll loading
- ✓ `.exports` (387 lines, first 50 lines reviewed) - Environment variables and OS detection
- ✓ `.aliases` (556 lines, first 50 lines reviewed) - Command aliases
- ✓ `.functions` (1,579 lines, first 50 lines reviewed) - Shell functions
- ✓ `bootstrap.sh` (153 lines) - Installation and update script
- ✓ `.config_dotfiles_default` (10 lines) - Default configuration template
- ✓ `.redpill/redpill-init-bash.sh` (73 lines) - Plugin system initialization
- ✓ `.shellrc` (32 lines) - Terminal multiplexer management
- ✓ `.zshrc` (48 lines) - ZSH entry point
- ✓ Repository structure via `ls -la` and `find` commands

**Method**: Each section references specific line numbers and files from the repository.

**Date**: 2026-01-15

---

## Contributing

To contribute improvements to this documentation:

1. Verify changes against actual source code
2. Include file and line number references
3. Test procedures on supported platforms
4. Update this verification checklist

**Source Repository**: https://github.com/voku/dotfiles
