# Usage Recipes & Examples

This guide provides practical examples and recipes for common use cases with the dotfiles.

---

## Table of Contents

- [Installation Scenarios](#installation-scenarios)
- [Daily Development Workflows](#daily-development-workflows)
- [Git Workflows](#git-workflows)
- [System Administration](#system-administration)
- [Multi-Platform Setup](#multi-platform-setup)
- [Team Collaboration](#team-collaboration)

---

## Installation Scenarios

### Scenario 1: Fresh Linux Installation

```bash
# 1. Install required packages (Debian/Ubuntu)
cd ~
git clone https://github.com/voku/dotfiles.git
cd dotfiles
./firstInstallDebianBased.sh

# 2. Install dotfiles
./bootstrap.sh

# 3. Configure for your user
vim ~/.config_dotfiles
# Set CONFIG_DEFAULT_USER="your-username"

# 4. Add personal settings
vim ~/.extra
# Add Git user info, custom aliases, etc.

# 5. Reload shell
source ~/.bashrc
```

### Scenario 2: macOS Setup

```bash
# 1. Install Xcode Command Line Tools
xcode-select --install

# 2. Clone dotfiles
cd ~
git clone https://github.com/voku/dotfiles.git
cd dotfiles

# 3. Install dotfiles
./bootstrap.sh

# 4. (Optional) Install Bash 4+ via Homebrew
brew install bash
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash

# 5. Configure macOS defaults
./.macos

# 6. Restart terminal
```

### Scenario 3: Windows with Git Bash

```bash
# 1. Install Git for Windows
# Download from: https://git-scm.com/download/win

# 2. Open Git Bash and clone dotfiles
cd ~
git clone https://github.com/voku/dotfiles.git
cd dotfiles

# 3. Install dotfiles
./bootstrap.sh

# 4. Configure
vim ~/.extra
# Add Windows-specific paths and settings
```

### Scenario 4: Windows with WSL (Ubuntu)

```bash
# 1. Enable WSL and install Ubuntu from Microsoft Store

# 2. In Ubuntu terminal, follow Linux installation
cd ~
git clone https://github.com/voku/dotfiles.git
cd dotfiles
./firstInstallDebianBased.sh
./bootstrap.sh

# 3. Add WSL-specific settings in ~/.extra
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
```

---

## Daily Development Workflows

### Workflow 1: Web Development Setup

```bash
# ~/.extra
#!/bin/sh

# Node.js version management (if using nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Yarn global bin
export PATH="$HOME/.yarn/bin:$PATH"

# Project shortcuts
alias frontend='cd ~/projects/frontend && code .'
alias backend='cd ~/projects/backend && code .'
alias devserver='npm run dev'

# Docker shortcuts
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'
alias dcrestart='docker-compose restart'

# Useful functions
function npmls() {
  about 'List globally installed npm packages'
  npm list -g --depth=0
}

function portcheck() {
  about 'Check what is running on a port'
  param '1: port number'
  example 'portcheck 3000'
  lsof -i ":$1"
}
```

### Workflow 2: Python Development

```bash
# ~/.extra
#!/bin/sh

# Python virtual environment management
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# Python aliases
alias py='python3'
alias ipy='ipython'
alias pyserver='python3 -m http.server'

# Project environments
alias activatemyproject='workon myproject'
alias djrun='python manage.py runserver'
alias djmig='python manage.py migrate'

# Functions
function mkvenv() {
  about 'Create and activate a new virtual environment'
  param '1: environment name'
  example 'mkvenv myproject'
  python3 -m venv "$1"
  source "$1/bin/activate"
}

function pipreqs() {
  about 'Generate requirements.txt from imports'
  pip freeze > requirements.txt
  echo "requirements.txt created"
}
```

### Workflow 3: Java/Maven Development

```bash
# ~/.extra
#!/bin/sh

# Java setup
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Maven setup
export MAVEN_HOME=/usr/local/maven
export PATH=$MAVEN_HOME/bin:$PATH
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"

# Aliases
alias mvnclean='mvn clean install -DskipTests'
alias mvntest='mvn test'
alias mvnrun='mvn spring-boot:run'

# Functions
function mvntree() {
  about 'Show Maven dependency tree'
  mvn dependency:tree
}

function mvnsearch() {
  about 'Search for artifact in local repo'
  param '1: search term'
  example 'mvnsearch "spring-boot"'
  find ~/.m2/repository -name "*$1*"
}
```

---

## Git Workflows

### Workflow 1: Feature Branch Development

```bash
# ~/.extra or ~/.redpill/plugins/custom.plugins.bash
#!/usr/bin/env bash

function git-start-feature() {
  about 'Start a new feature branch'
  param '1: feature name'
  example 'git-start-feature user-authentication'
  
  local feature_name="$1"
  
  if [[ -z "$feature_name" ]]; then
    echo "Usage: git-start-feature <feature-name>"
    return 1
  fi
  
  git checkout main
  git pull origin main
  git checkout -b "feature/$feature_name"
  echo "Started feature branch: feature/$feature_name"
}

function git-finish-feature() {
  about 'Finish feature branch and merge to main'
  
  local current_branch=$(git branch --show-current)
  
  if [[ ! "$current_branch" =~ ^feature/ ]]; then
    echo "Not on a feature branch"
    return 1
  fi
  
  git checkout main
  git pull origin main
  git merge "$current_branch" --no-ff
  git push origin main
  git branch -d "$current_branch"
  echo "Merged and deleted: $current_branch"
}

# Aliases
alias gsf='git-start-feature'
alias gff='git-finish-feature'
```

### Workflow 2: Quick Commit Workflow

```bash
# ~/.extra
#!/bin/sh

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# Quick commit with message
function gcm() {
  about 'Quick commit with message'
  param '1: commit message'
  example 'gcm "Fix bug in login"'
  
  git add --all
  git commit -m "$*"
}

# Quick commit and push
function gcp() {
  about 'Quick commit and push'
  param '1: commit message'
  example 'gcp "Update documentation"'
  
  git add --all
  git commit -m "$*"
  git push
}

# Undo last commit (keep changes)
alias gundo='git reset --soft HEAD~1'

# Amend last commit
alias gamend='git commit --amend --no-edit'
```

### Workflow 3: Multi-Repository Management

```bash
# ~/.extra
#!/bin/sh

# Repository locations
export REPO_DIR="$HOME/projects"
export REPOS="frontend backend api mobile"

function repos-status() {
  about 'Check status of all repositories'
  
  for repo in $REPOS; do
    echo "=== $repo ==="
    (cd "$REPO_DIR/$repo" && git status -s)
    echo ""
  done
}

function repos-pull() {
  about 'Pull latest changes for all repositories'
  
  for repo in $REPOS; do
    echo "=== Pulling $repo ==="
    (cd "$REPO_DIR/$repo" && git pull)
    echo ""
  done
}

function repos-branch() {
  about 'Show current branch for all repositories'
  
  for repo in $REPOS; do
    local branch=$(cd "$REPO_DIR/$repo" && git branch --show-current)
    echo "$repo: $branch"
  done
}

# Aliases
alias rst='repos-status'
alias rpl='repos-pull'
alias rbr='repos-branch'
```

---

## System Administration

### Workflow 1: Server Monitoring

```bash
# ~/.extra
#!/bin/sh

# System monitoring aliases
alias cpu='top -o %CPU'
alias mem='top -o %MEM'
alias ports='netstat -tulanp'
alias diskspace='df -h'
alias diskusage='du -sh * | sort -h'

# Functions
function listening() {
  about 'Show listening ports'
  netstat -tuln | grep LISTEN
}

function processinfo() {
  about 'Get detailed process information'
  param '1: process name or PID'
  example 'processinfo nginx'
  
  ps aux | grep "$1" | grep -v grep
}

function killport() {
  about 'Kill process running on specified port'
  param '1: port number'
  example 'killport 8080'
  
  local pid=$(lsof -ti tcp:"$1")
  if [[ -n "$pid" ]]; then
    kill -9 "$pid"
    echo "Killed process on port $1 (PID: $pid)"
  else
    echo "No process found on port $1"
  fi
}
```

### Workflow 2: Log Monitoring

```bash
# ~/.extra
#!/bin/sh

# Log viewing shortcuts
alias logs-apache='tail -f /var/log/apache2/error.log'
alias logs-nginx='tail -f /var/log/nginx/error.log'
alias logs-syslog='tail -f /var/log/syslog'
alias logs-auth='tail -f /var/log/auth.log'

# Functions
function logs-app() {
  about 'Tail application logs with grep filter'
  param '1: log file path'
  param '2: grep pattern (optional)'
  example 'logs-app /var/log/app.log ERROR'
  
  local logfile="$1"
  local pattern="$2"
  
  if [[ -n "$pattern" ]]; then
    tail -f "$logfile" | grep --color=always "$pattern"
  else
    tail -f "$logfile"
  fi
}

function logs-search() {
  about 'Search logs for pattern'
  param '1: log file path'
  param '2: search pattern'
  example 'logs-search /var/log/app.log "error"'
  
  grep -i "$2" "$1" | tail -50
}
```

---

## Multi-Platform Setup

### Syncing Configuration Across Machines

```bash
# ~/.extra (on all machines)
#!/bin/sh

# Detect hostname and set machine-specific config
case "$(hostname)" in
  "work-laptop")
    # Work laptop settings
    export GIT_AUTHOR_EMAIL="work@company.com"
    CONFIG_TERM_LOCAL="tmux"
    ;;
    
  "home-desktop")
    # Home desktop settings
    export GIT_AUTHOR_EMAIL="personal@gmail.com"
    CONFIG_TERM_LOCAL=""
    ;;
    
  "server-prod")
    # Production server settings
    export GIT_AUTHOR_EMAIL="admin@server.com"
    CONFIG_TERM_SSH="screen"
    PS1="[\[\033[01;31m\]PROD\[\033[00m\]] $PS1"
    ;;
esac

# Shared settings across all machines
export DOTFILESSRCDIR="$HOME/dotfiles"
```

### Platform-Specific Customizations

```bash
# ~/.extra
#!/bin/sh

if [[ "$SYSTEM_TYPE" == "OSX" ]]; then
  # macOS-specific
  export JAVA_HOME=$(/usr/libexec/java_home)
  alias ls='ls -G'
  alias flushdns='sudo killall -HUP mDNSResponder'
  
  # Homebrew
  export PATH="/usr/local/bin:$PATH"
  
elif [[ "$SYSTEM_TYPE" == "LINUX" ]]; then
  # Linux-specific
  export JAVA_HOME=/usr/lib/jvm/default-java
  alias ls='ls --color=auto'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  
  # APT shortcuts
  alias aptup='sudo apt update && sudo apt upgrade -y'
  alias aptin='sudo apt install'
  
elif [[ "$SYSTEM_TYPE" == "MINGW" ]] || [[ "$SYSTEM_TYPE" == "CYGWIN" ]]; then
  # Windows-specific
  export PATH="/c/Program Files/tools:$PATH"
  alias open='explorer'
fi
```

---

## Team Collaboration

### Shared Team Configuration

Create a team-specific dotfiles extension:

```bash
# Clone team dotfiles
cd ~
git clone https://github.com/company/team-dotfiles.git

# In ~/.extra
#!/bin/sh

# Source team-specific configuration
if [[ -f "$HOME/team-dotfiles/.team_aliases" ]]; then
  source "$HOME/team-dotfiles/.team_aliases"
fi

if [[ -f "$HOME/team-dotfiles/.team_functions" ]]; then
  source "$HOME/team-dotfiles/.team_functions"
fi
```

### team-dotfiles/.team_aliases

```bash
#!/usr/bin/env bash

# Project-specific shortcuts
alias project1='cd ~/projects/project1 && code .'
alias project2='cd ~/projects/project2 && code .'

# Deployment shortcuts
alias deploy-staging='./deploy.sh staging'
alias deploy-prod='./deploy.sh production'

# Database shortcuts
alias db-staging='mysql -h staging-db.company.com -u admin -p staging_db'
alias db-prod='mysql -h prod-db.company.com -u admin -p prod_db'

# SSH shortcuts
alias ssh-staging='ssh deploy@staging.company.com'
alias ssh-prod='ssh deploy@prod.company.com'
```

### team-dotfiles/.team_functions

```bash
#!/usr/bin/env bash

function team-standup() {
  about 'Generate standup report'
  
  echo "=== Git commits since yesterday ==="
  git log --author="$(git config user.name)" --since="yesterday" --pretty=format:"%h - %s"
  
  echo -e "\n\n=== Current branch ==="
  git branch --show-current
  
  echo -e "\n=== Working on ==="
  git status -s
}

function team-deploy() {
  about 'Standardized deployment process'
  param '1: environment (staging|production)'
  
  local env="$1"
  
  if [[ "$env" != "staging" && "$env" != "production" ]]; then
    echo "Usage: team-deploy {staging|production}"
    return 1
  fi
  
  echo "Deploying to $env..."
  
  # Run tests
  echo "Running tests..."
  npm test
  
  # Build
  echo "Building..."
  npm run build
  
  # Deploy
  echo "Deploying..."
  ./deploy.sh "$env"
  
  echo "Deployment complete!"
}
```

---

## Tips and Tricks

### 1. Temporary Aliases

Create temporary aliases for your current session:

```bash
# One-time alias (lost after closing terminal)
alias temp='cd /path/to/temp/project'

# Use it
temp
```

### 2. Command History Search

```bash
# Press Ctrl+R and type to search command history
# Press Ctrl+R again to cycle through matches

# Or use grep on history
history | grep "git commit"
```

### 3. Directory Bookmarks with pushd/popd

```bash
# Save current directory and change to new one
pushd /path/to/project

# Return to previous directory
popd

# View directory stack
dirs -v
```

### 4. Quick File Editing

```bash
# Edit and reload bashrc
alias editbash='vim ~/.bashrc && source ~/.bashrc'
alias editextra='vim ~/.extra && source ~/.extra'

# Edit commonly used files
alias edithosts='sudo vim /etc/hosts'
```

### 5. Function Testing

```bash
# Test a function before adding to .extra
function test_function() {
  echo "Testing..."
}

# If it works, add to ~/.extra
```

---

## See Also

- [Technical Documentation](TECHNICAL_DOCUMENTATION.md) - Complete architecture reference
- [Configuration Guide](CONFIGURATION.md) - Configuration options
- [Plugin System Guide](PLUGINS.md) - Plugin development
- [README.md](../README.md) - Quick start guide
