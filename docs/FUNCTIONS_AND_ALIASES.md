# Functions and Aliases Guide

This guide documents the structure and most useful features in `.functions` and `.aliases` files, making it easy for users to cherry-pick specific features for their own dotfiles.

---

## Table of Contents

- [Overview](#overview)
- [File Structure](#file-structure)
- [How to Cherry-Pick](#how-to-cherry-pick)
- [Most Useful Functions](#most-useful-functions)
- [Most Useful Aliases](#most-useful-aliases)
- [Complete Function Reference](#complete-function-reference)
- [Complete Alias Categories](#complete-alias-categories)

---

## Overview

### `.functions` File

The `.functions` file (1,579 lines) contains custom shell functions that extend your command-line capabilities. Functions are more powerful than aliases because they can:
- Accept parameters
- Contain complex logic
- Return values
- Use local variables

### `.aliases` File

The `.aliases` file (556 lines) contains shorthand commands and command modifications organized into logical categories. Aliases are simpler than functions but perfect for:
- Quick shortcuts (e.g., `g` for `git`)
- Adding default flags to commands (e.g., `rm='rm -I'`)
- Common command combinations

---

## File Structure

### `.functions` Structure

Functions are organized with clear documentation headers:

```bash
# -------------------------------------------------------------------
# function_name: Brief description of what it does
#
# example:
#
# function_name arg1 arg2
#
function_name()
{
  # implementation
}
```

Each function includes:
- **Header comment** with description
- **Usage examples** where helpful
- **Parameter documentation** for complex functions
- **Clean separation** with horizontal rules

### `.aliases` Structure

Aliases are organized into logical sections:

```bash
# ------------------------------------------------------------------------------
# | Section Name                                                               |
# ------------------------------------------------------------------------------

alias shortcut='full command'
alias another='another command'
```

Main sections include:
1. **Defaults** - Core system modifications
2. **Global Quick Commands** - Short shortcuts (g, h, j)
3. **Navigation** - Directory movement helpers
4. **Directory Commands** - mkdir, rmdir shortcuts
5. **Colors** - Color-related aliases
6. **List Directory Contents** - ls variations
7. **Search and Find** - grep, find shortcuts
8. **Package Managers** - apt, yum, npm, etc.
9. **Network** - Network diagnostic tools
10. **Date & Time** - Time-related commands
11. **System Utilities** - System management
12. **Other** - Miscellaneous utilities
13. **Fun** - Entertainment commands

---

## How to Cherry-Pick

### Copy Individual Functions

1. **Find the function** you want in `.functions`
2. **Copy from the header comment** through the closing `}`
3. **Paste into your dotfiles** (e.g., `~/.bash_functions` or `~/.zshrc`)
4. **Source the file** in your shell profile

Example - copying the `mkd` function:

```bash
# From .functions (lines 408-418):
# -------------------------------------------------------------------
# mkd: Create a new directory and enter it
mkd()
{
  mkdir -p "$@" && cd "$_"
}
```

Add to your dotfiles:
```bash
# In your ~/.bashrc or ~/.zshrc
mkd() {
  mkdir -p "$@" && cd "$_"
}
```

### Copy Individual Aliases

1. **Find the alias** in `.aliases`
2. **Copy the line** (and any dependencies)
3. **Add to your dotfiles**

Example:
```bash
# From .aliases:
alias g="git"
alias ..="cd .."
alias path="echo -e ${PATH//:/\\n}"
```

### Copy Entire Sections

To copy a whole section:

1. **Identify the section** by its header comment
2. **Copy from header** to the next section header
3. **Paste into your dotfiles**

Example - copying the entire Navigation section:
```bash
# ------------------------------------------------------------------------------
# | Navigation                                                                 |
# ------------------------------------------------------------------------------

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# ... rest of section
```

---

## Most Useful Functions

### 🔥 Top 10 Functions You Should Cherry-Pick

#### 1. `mkd` - Create and Enter Directory
**Lines:** 408-418 in `.functions`

```bash
mkd() {
  mkdir -p "$@" && cd "$_"
}
```

**Why useful:** Combines `mkdir` and `cd` into one command.

**Usage:**
```bash
mkd new-project
# Creates directory and moves into it
```

---

#### 2. `extract` - Universal Archive Extractor
**Lines:** 260-304 in `.functions`

```bash
extract() {
  # Automatically detects and extracts any archive format
  # Supports: tar, gz, bz2, zip, rar, 7z, and more
}
```

**Why useful:** No need to remember different extraction commands for different formats.

**Usage:**
```bash
extract archive.tar.gz
extract package.zip
extract file.7z
```

---

#### 3. `dataurl` - Convert File to Data URL
**Lines:** 622-633 in `.functions`

```bash
dataurl() {
  # Converts file to base64 data URL
  # Perfect for embedding images in CSS/HTML
}
```

**Why useful:** Instantly create data URLs for web development.

**Usage:**
```bash
dataurl image.png
# Outputs: data:image/png;base64,iVBORw0KG...
```

---

#### 4. `server` - Instant HTTP Server
**Lines:** 505-510 in `.functions`

```bash
server() {
  # Starts a local web server in current directory
  # Uses Python's SimpleHTTPServer
}
```

**Why useful:** Quick local web server for testing.

**Usage:**
```bash
server
# Serves current directory on http://localhost:8000
```

---

#### 5. `targz` - Smart Compression
**Lines:** 451-459 in `.functions`

```bash
targz() {
  # Creates tar.gz with optimized compression
  # Uses zopfli if available, otherwise gzip
}
```

**Why useful:** Creates smallest possible archives automatically.

**Usage:**
```bash
targz folder-name
# Creates folder-name.tar.gz
```

---

#### 6. `calc` - Command-Line Calculator
**Lines:** 384-407 in `.functions`

```bash
calc() {
  # Full-featured calculator with bc
  # Supports floating point math
}
```

**Why useful:** Quick calculations without leaving terminal.

**Usage:**
```bash
calc "2 + 2"          # 4
calc "3.14 * 2^2"     # 12.56
calc "scale=2; 22/7"  # 3.14
```

---

#### 7. `fs` - Get File/Directory Size
**Lines:** 476-489 in `.functions`

```bash
fs() {
  # Human-readable size of file or directory
  # Works on Linux and macOS
}
```

**Why useful:** Quick way to check sizes.

**Usage:**
```bash
fs ~/Downloads
# Output: 2.5G
```

---

#### 8. `ff` - Fast Find
**Lines:** 491-503 in `.functions`

```bash
ff() {
  # Fast file search by name
  # Case-insensitive, shows results immediately
}
```

**Why useful:** Easier than typing full `find` commands.

**Usage:**
```bash
ff "*.js"
# Finds all JavaScript files
```

---

#### 9. `lc` / `uc` - Case Conversion
**Lines:** 45-69 in `.functions`

```bash
lc() { # lowercase
  # Converts input to lowercase
}

uc() { # uppercase  
  # Converts input to uppercase
}
```

**Why useful:** Easy text case conversion.

**Usage:**
```bash
echo "HELLO" | lc    # hello
echo "world" | uc    # WORLD
lc "MixedCase"       # mixedcase
```

---

#### 10. `repo` - Open Git Repo in Browser
**Lines:** 71-100 in `.functions`

```bash
repo() {
  # Opens current git repository in web browser
  # Works with GitHub and Bitbucket
}
```

**Why useful:** Instant access to GitHub/Bitbucket from terminal.

**Usage:**
```bash
# In any git repository:
repo
# Opens https://github.com/user/repo in browser
```

---

### 🎯 Other Notable Functions

#### File Operations
- **`file_backup`** (lines 599-611) - Quick file backups with timestamps
- **`file_backup_compressed`** (lines 592-597) - Compressed backups
- **`stripspace`** (lines 320-330) - Remove trailing whitespace
- **`replace`** (lines 354-367) - Find and replace in files

#### Network Utilities
- **`ips`** (lines 260-258) - Show all IP addresses
- **`sniff`** (lines 260-236) - Sniff HTTP traffic
- **`httpdump`** (lines 232-234) - Dump HTTP traffic

#### System Info
- **`battery_life`** (lines 332-342) - Show battery percentage (macOS)
- **`mount_info`** (lines 218-224) - Pretty mount information
- **`netstat_used_local_ports`** (lines 176-179) - Show used ports

#### Development
- **`json`** (lines 543-570) - Pretty-print JSON
- **`gitignore`** (lines 1120-1140) - Generate .gitignore files
- **`diff`** (lines 1142-1148) - Enhanced diff with colors

---

## Most Useful Aliases

### 🔥 Top 20 Aliases You Should Cherry-Pick

#### Safety & Defaults

```bash
# Safer rm - prompts only when removing 3+ files
alias rm='rm -I'

# Safety features for system commands
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
```

**Why:** Prevents accidental file deletion and system damage.

---

#### Quick Shortcuts

```bash
# Super short commands
alias g="git"
alias h="history"
alias j="jobs"

# Quick editing
alias zshrc="vim ~/.zshrc"
alias bashrc="vim ~/.bashrc"
alias vimrc="vim ~/.vimrc"

# Reload shell
alias reload="exec $SHELL -l"
```

**Why:** Save keystrokes on frequently used commands.

---

#### Navigation

```bash
# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Directory stack
alias pu='pushd'
alias po='popd'

# Show PATH entries on separate lines
alias path="echo -e ${PATH//:/\\n}"
```

**Why:** Navigate directories faster and understand your PATH.

---

#### Directory Commands

```bash
# Directory shortcuts
alias md='mkdir -p'
alias rd='rmdir'

# Tree view
alias tree="tree -CAFa -I 'CVS|*.*.package|.svn|.git|node_modules' --dirsfirst"

# Directory size
alias dud='du -d 1 -h'
alias duf='du -sh *'
```

**Why:** Quick directory operations and visualization.

---

#### Enhanced ls

```bash
# Basic ls variations
alias ls='ls -F'
alias l='ls -lFh'      # size, show type, human readable
alias la='ls -lAFh'    # long list, show almost all
alias ll='ls -l'       # long list
alias ldot='ls -ld .*' # list dot files

# Colorized output
alias dir="ls --format=vertical $COLORFLAG"
alias vdir="ls --format=long $COLORFLAG"
```

**Why:** Better file listing with useful defaults.

---

#### Search & Find

```bash
# Better grep
alias grep="grep $GREP_OPTIONS"

# Quick finds
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# History search
alias h1='history 10'
alias h2='history 20'
alias h3='history 30'
alias hgrep='history | grep'
```

**Why:** Faster searching and filtering.

---

#### Git Shortcuts

```bash
# Basic git
alias g="git"
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log'
alias gp='git push'
alias gs='git status'

# Advanced git
alias glog='git log --oneline --decorate --graph --all'
alias gcm='git checkout master'
```

**Why:** Essential git productivity shortcuts.

---

#### Package Managers

```bash
# APT (Debian/Ubuntu)
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias install='sudo apt install'

# NPM
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nog='npm outdated -g'
```

**Why:** Faster package management.

---

#### Network

```bash
# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Network info
alias netinfo='netstat -nr'

# HTTP tools
alias GET='curl -X GET'
alias POST='curl -X POST'
alias PUT='curl -X PUT'
alias DELETE='curl -X DELETE'
```

**Why:** Quick network diagnostics and HTTP requests.

---

#### System Info

```bash
# Process info
alias pscpu="ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 5"
alias psmem="ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6"

# Disk usage
alias diskspace="du -S | sort -n -r | more"
alias df='df -h'

# Show open ports
alias ports='netstat -tulanp'
```

**Why:** Monitor system resources easily.

---

#### Date & Time

```bash
# Date formats
alias now='date +"%T"'
alias nowtime='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias week='date +%V'
```

**Why:** Quick date/time information.

---

#### Other Utilities

```bash
# Clipboard (macOS)
alias c='pbcopy'
alias v='pbpaste'

# URL encode/decode
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Make commands
alias m='make'
alias mi='make install'

# Cleanup
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias emptytrash="rm -rfv ~/.local/share/Trash/*"
```

**Why:** Common utility operations made simple.

---

## Complete Function Reference

### All Functions by Category

#### Basic Utilities
- `err` - Error message with timestamp
- `cd` - Enhanced cd with ... shortcuts and autoenv support
- `cdo` - Change to previous directory (OLDPWD)
- `lc` - Convert to lowercase
- `uc` - Convert to uppercase

#### Git & Repository
- `repo` - Open git repository in browser
- `gitignore` - Generate .gitignore files
- `git-*` - Various git helper functions

#### Network
- `netstat_used_local_ports` - Show used ports
- `netstat_free_local_port` - Find free port
- `netstat_connection_overview` - Network connection summary
- `sniff` - Sniff HTTP traffic
- `httpdump` - Dump HTTP requests
- `ips` - Show all IP addresses

#### File Operations
- `extract` - Universal archive extractor
- `targz` - Create optimized tar.gz
- `fs` - Get file/directory size
- `ff` - Fast find files
- `fstr` - Find string in files
- `file_backup` - Backup file with timestamp
- `file_backup_compressed` - Compressed backup
- `dataurl` - Convert file to data URL

#### Development
- `json` - Pretty-print JSON
- `server` - Start HTTP server
- `calc` - Command-line calculator
- `diff` - Enhanced diff
- `wtfis` - Look up info about command/domain

#### System
- `mount_info` - Pretty mount information
- `battery_life` - Show battery status (macOS)
- `battery_indicator` - Battery indicator character
- `command_exists` - Check if command exists

#### Text Processing
- `stripspace` - Remove trailing whitespace
- `replace` - Find and replace in files
- `box` - Draw box around text
- `man` - Enhanced man pages with colors

#### Misc
- `mkd` - Make directory and enter it
- `mkf` - Make file and parent directories
- `rand_int` - Generate random integer
- `passwdgen` - Generate random password
- `duh` - Disk usage with human-readable output

---

## Complete Alias Categories

### Full Category List

#### 1. Defaults
Core system modifications and safety features.

#### 2. Global Quick Commands  
Ultra-short shortcuts for common commands.

#### 3. Navigation
Directory movement and stack operations.

#### 4. Directory Commands
Creating, removing, and viewing directories.

#### 5. Colors
Color-related configurations and commands.

#### 6. List Directory Contents
Various `ls` command variations.

#### 7. Search and Find
Grep, find, and search utilities.

#### 8. Package Managers
APT, YUM, NPM, Composer, Gem, Pip shortcuts.

#### 9. Network
IP addresses, HTTP tools, network diagnostics.

#### 10. Date & Time
Date formatting and timezone utilities.

#### 11. Hard & Software Info
System information commands.

#### 12. System Utilities
Process management, disk usage, etc.

#### 13. Other
Miscellaneous utilities (clipboard, encoding, etc.).

#### 14. Fun
Entertainment commands (matrix, starwars, etc.).

#### 15. Auto-completion
Bash completion enhancements.

---

## Tips for Integration

### 1. Test First
Always test cherry-picked functions/aliases in a new shell session before adding to your main dotfiles:

```bash
# Test in current session
source /tmp/test-functions.sh
mkd test-dir  # Try it out
```

### 2. Check Dependencies
Some functions require external tools:
- `extract` - needs tar, unzip, etc.
- `json` - needs python or node
- `dataurl` - needs base64 and file commands

Verify with:
```bash
command -v tool_name
```

### 3. Adapt for Your Shell
- **Bash users:** Most functions work as-is
- **Zsh users:** Some syntax may need adjustment
- **Fish users:** Will need translation to Fish syntax

### 4. Namespace Your Additions
Consider prefixing cherry-picked items:

```bash
# Original
alias g="git"

# Prefixed to avoid conflicts
alias myg="git"
```

### 5. Document Your Additions
Add comments explaining what you cherry-picked:

```bash
# From voku/dotfiles .functions
# Creates directory and enters it
mkd() {
  mkdir -p "$@" && cd "$_"
}
```

---

## Contributing Back

If you improve any function or alias, consider contributing back:

1. Fork the repository
2. Make your improvements
3. Submit a pull request
4. Help others benefit from your enhancements

---

## License

These functions and aliases are part of the voku/dotfiles repository and are available under the MIT License. See [LICENSE-MIT.txt](../LICENSE-MIT.txt) for details.

---

## Additional Resources

- **[Main README](../README.md)** - Installation and setup
- **[Technical Documentation](TECHNICAL_DOCUMENTATION.md)** - Architecture details
- **[Configuration Guide](CONFIGURATION.md)** - Customization options
- **[Plugin System](PLUGINS.md)** - Plugin documentation

---

**Last Updated:** 2026-01-15
