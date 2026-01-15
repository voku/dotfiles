# Plugin System Guide

This guide explains the `.redpill` plugin system architecture and how to create and use plugins.

## Overview

The `.redpill` plugin system is inspired by oh-my-zsh and provides:
- Modular functionality through plugins
- Themed prompts with Git integration
- Custom aliases, completions, and functions
- Function metadata via composure

---

## Plugin Architecture

### Directory Structure

```
~/.redpill/
├── redpill-init-bash.sh          # Bash plugin initialization
├── redpill-init-zsh.sh           # ZSH plugin initialization
│
├── lib/                          # Core libraries
│   ├── composure.bash            # Function metadata system
│   └── *.bash                    # Other library files
│
├── themes/                       # Prompt themes
│   ├── colors.theme.bash         # Color definitions
│   ├── base.theme.bash           # Base theme
│   └── *.theme.bash              # Additional themes
│
├── bash_prompt/                  # Bash prompt components
│   ├── gitprompt.sh              # Git-aware prompt
│   ├── gitstatus.sh              # Git status detection
│   └── prompt-colors.sh          # Prompt color definitions
│
├── zsh_prompt/                   # ZSH prompt components
│   └── zshrc.sh                  # ZSH prompt configuration
│
├── plugins/                      # Plugin system
│   ├── available/                # Available plugins
│   │   ├── base.plugin.bash     # Base plugin (always loaded)
│   │   ├── git.plugin.bash      # Git plugin
│   │   └── *.plugin.bash        # Other plugins
│   ├── enabled/                  # Enabled plugins (legacy)
│   └── custom.plugins.bash       # User custom plugins
│
├── aliases/                      # Plugin aliases
│   ├── available/
│   │   └── *.aliases.bash       # Plugin-specific aliases
│   └── custom.aliases.bash      # User custom aliases
│
├── completion/                   # Plugin completions
│   ├── available/
│   │   └── *.completion.bash    # Plugin-specific completions
│   └── custom.completion.bash   # User custom completions
│
└── tests/                        # Test suite
    └── functions-tests.sh       # Function tests
```

---

## Plugin Loading Process

### Initialization Sequence (Bash)

From `~/.redpill/redpill-init-bash.sh`:

1. **Load Composure**: Function metadata system
   ```bash
   source "${REDPILL}/lib/composure.bash"
   ```

2. **Load Themes**: Colors and base theme
   ```bash
   source "${REDPILL}/themes/colors.theme.bash"
   source "${REDPILL}/themes/base.theme.bash"
   ```

3. **Load Libraries**: All files in `lib/*.bash`
   ```bash
   for config_file in ${REDPILL}/lib/*.bash; do
     # This check handles the case where no .bash files exist in the lib directory
     [ -f "$config_file" ] && source "$config_file"
   done
   ```

4. **Load Base Plugin**: Always loaded
   ```bash
   source "${REDPILL}/plugins/available/base.plugin.bash"
   ```

5. **Load Configured Plugins**: Based on `CONFIG_BASH_PLUGINS`
   ```bash
   for plugin in ${plugins[@]}; do
     # Load aliases/available/${plugin}.aliases.bash
     # Load completion/available/${plugin}.completion.bash
     # Load plugins/available/${plugin}.plugin.bash
   done
   ```

6. **Load Custom Files**: User customizations
   ```bash
   # Load custom.aliases.bash, custom.completion.bash, custom.plugins.bash
   ```

7. **Load Git Prompt**: Git-aware prompt
   ```bash
   source "${REDPILL}/bash_prompt/gitprompt.sh"
   ```

---

## Available Plugins

Check available plugins:

```bash
ls -1 ~/.redpill/plugins/available/
```

Common plugins include:
- `base.plugin.bash` - Base functionality (always loaded)
- `git.plugin.bash` - Git aliases and functions
- `z.plugin.bash` - Fast directory jumping
- `wd.plugin.bash` - Warp directory (bookmarks)
- `todo.plugin.bash` - Todo list management

---

## Enabling Plugins

### Configure in ~/.config_dotfiles

```bash
# Enable single plugin
CONFIG_BASH_PLUGINS="(git)"

# Enable multiple plugins
CONFIG_BASH_PLUGINS="(git z wd)"

# For ZSH
CONFIG_ZSH_PLUGINS="(git zsh-completions zsh-syntax-highlighting)"
```

**Note**: Plugins are space-separated within parentheses.

### Reload Configuration

After changing plugin configuration:

```bash
# Reload bash
source ~/.bashrc

# Or open a new terminal
```

---

## Creating Custom Plugins

### Method 1: Custom Plugin File

Create `~/.redpill/plugins/custom.plugins.bash`:

```bash
#!/usr/bin/env bash

# Plugin metadata (optional)
cite about-plugin
about-plugin 'My custom plugin for project management'

# Define functions
function project-init() {
  about 'Initialize a new project'
  group 'project'
  
  local project_name="$1"
  
  if [[ -z "$project_name" ]]; then
    echo "Usage: project-init <project-name>"
    return 1
  fi
  
  mkdir -p "$project_name"/{src,tests,docs}
  cd "$project_name"
  git init
  echo "# $project_name" > README.md
  echo "Project initialized: $project_name"
}

function project-deploy() {
  about 'Deploy project to production'
  group 'project'
  
  echo "Deploying project..."
  # deployment logic here
}

# Define aliases
alias pi='project-init'
alias pd='project-deploy'
```

### Method 2: Create a Full Plugin

Create `~/.redpill/plugins/available/myproject.plugin.bash`:

```bash
#!/usr/bin/env bash

cite about-plugin
about-plugin 'Project management plugin'

# Main plugin functionality
function myproject() {
  local cmd="$1"
  shift
  
  case "$cmd" in
    init)
      _myproject_init "$@"
      ;;
    deploy)
      _myproject_deploy "$@"
      ;;
    *)
      echo "Usage: myproject {init|deploy}"
      return 1
      ;;
  esac
}

function _myproject_init() {
  echo "Initializing project: $1"
  # initialization logic
}

function _myproject_deploy() {
  echo "Deploying project"
  # deployment logic
}
```

Create `~/.redpill/aliases/available/myproject.aliases.bash`:

```bash
#!/usr/bin/env bash

cite about-alias
about-alias 'myproject aliases'

alias pi='myproject init'
alias pd='myproject deploy'
```

Create `~/.redpill/completion/available/myproject.completion.bash`:

```bash
#!/usr/bin/env bash

cite about-completion
about-completion 'myproject completion'

_myproject_completion() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local cmd="${COMP_WORDS[1]}"
  
  if [[ $COMP_CWORD -eq 1 ]]; then
    COMPREPLY=($(compgen -W "init deploy status" -- "$cur"))
  fi
}

complete -F _myproject_completion myproject
```

Enable the plugin in `~/.config_dotfiles`:

```bash
CONFIG_BASH_PLUGINS="(git myproject)"
```

---

## Plugin Metadata with Composure

Composure allows documenting functions with metadata.

### Available Metadata

- `about` - Short description
- `param` - Parameter description
- `example` - Usage example
- `group` - Functional group
- `author` - Author name
- `version` - Version number

### Example with Metadata

```bash
#!/usr/bin/env bash

function database-backup() {
  about 'Backup database to file'
  param '1: database name'
  param '2: output file (optional)'
  example 'database-backup mydb'
  example 'database-backup mydb /backups/mydb.sql'
  group 'database'
  author 'John Doe'
  version '1.0'
  
  local db_name="$1"
  local output="${2:-${db_name}_$(date +%Y%m%d).sql}"
  
  echo "Backing up $db_name to $output..."
  mysqldump "$db_name" > "$output"
}
```

### Viewing Function Metadata

```bash
# List all functions with metadata
typeset -f | grep '^[a-zA-Z]'

# View function help
glossary database-backup

# List functions by group
glossary group database
```

---

## Custom Aliases

### Create Custom Aliases File

File: `~/.redpill/aliases/custom.aliases.bash`

```bash
#!/usr/bin/env bash

cite about-alias
about-alias 'custom project aliases'

# Project shortcuts
alias work='cd ~/workspace'
alias myproject='cd ~/projects/my-awesome-project'

# Git shortcuts
alias gst='git status'
alias gco='git checkout'
alias gcm='git commit -m'
alias gp='git push'

# Docker shortcuts
alias dps='docker ps'
alias dimg='docker images'
alias dex='docker exec -it'

# System shortcuts
alias updateall='sudo apt update && sudo apt upgrade -y'
```

---

## Custom Completions

### Create Custom Completions File

File: `~/.redpill/completion/custom.completion.bash`

```bash
#!/usr/bin/env bash

cite about-completion
about-completion 'custom completions'

# Completion for custom deploy command
_deploy_completion() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local environments="dev staging production"
  
  COMPREPLY=($(compgen -W "$environments" -- "$cur"))
}
complete -F _deploy_completion deploy

# Completion for custom project command
_project_completion() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  # Use a glob to safely get directory names instead of parsing `ls`.
  local projects=()
  for dir in ~/projects/*/; do
    [[ -d "$dir" ]] && projects+=("$(basename "$dir")")
  done
  COMPREPLY=($(compgen -W "${projects[*]}" -- "$cur"))
}
complete -F _project_completion project
```

---

## Theme Customization

### Available Themes

Check available themes:

```bash
ls -1 ~/.redpill/themes/*.theme.bash
```

### Set Theme in Configuration

In `~/.config_dotfiles`:

```bash
CONFIG_BASH_THEME="voku"
CONFIG_ZSH_THEME="voku"
```

### Create Custom Theme

File: `~/.redpill/themes/mytheme.theme.bash`

```bash
#!/usr/bin/env bash

# Color definitions
SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" ${cyan}("
SCM_THEME_PROMPT_SUFFIX="${cyan})"

# Prompt format
function prompt_command() {
  PS1="\n${bold_cyan}$(scm_char)${green}$(scm_prompt_info) ${purple}\h ${reset_color}in ${yellow}\w ${reset_color}\n$ "
}

safe_append_prompt_command prompt_command
```

---

## Best Practices

### 1. Plugin Organization

✅ **Do**:
- Keep plugin files focused and single-purpose
- Use descriptive function names with plugin prefix
- Document functions with composure metadata
- Group related functionality

❌ **Don't**:
- Create monolithic plugins with unrelated functions
- Use generic function names that may conflict
- Skip documentation

### 2. Performance Considerations

✅ **Do**:
- Keep plugin list minimal (only load what you need)
- Use lazy loading for expensive operations
- Cache results when possible

❌ **Don't**:
- Load unnecessary plugins
- Run expensive commands during initialization
- Make network calls during plugin load

### 3. Compatibility

✅ **Do**:
- Test plugins in both Bash and ZSH (if applicable)
- Check for command availability before using
- Handle errors gracefully

❌ **Don't**:
- Assume specific tools are installed
- Use shell-specific syntax without checking
- Fail silently on errors

### 4. Custom Files vs. Forking

Use custom files (`custom.*.bash`) for:
- Personal commands and aliases
- Project-specific functionality
- Experimental features

Fork the repository for:
- Bug fixes
- New features to contribute back
- Significant customizations you want to version control

---

## Testing Plugins

### Run Function Tests

```bash
# Test with Bash
bash ~/.redpill/tests/functions-tests.sh

# Test with ZSH
zsh ~/.redpill/tests/functions-tests.sh
```

### Manual Testing

```bash
# Reload shell configuration
source ~/.bashrc

# Test function exists
type my_function

# Test function execution
my_function test-argument

# Check function metadata
glossary my_function
```

---

## Troubleshooting

### Plugin Not Loading

1. **Check plugin is enabled**:
   ```bash
   source ~/.config_dotfiles
   echo "$CONFIG_BASH_PLUGINS"
   ```

2. **Verify plugin file exists**:
   ```bash
   ls -la ~/.redpill/plugins/available/myplugin.plugin.bash
   ```

3. **Check for syntax errors**:
   ```bash
   bash -n ~/.redpill/plugins/available/myplugin.plugin.bash
   ```

4. **Check file permissions**:
   ```bash
   ls -la ~/.redpill/plugins/available/
   ```

### Function Not Found

1. **Verify function is defined**:
   ```bash
   type function_name
   ```

2. **Check if plugin loaded**:
   ```bash
   # Add debug output to plugin file
   echo "Loading myplugin"
   ```

3. **Reload shell**:
   ```bash
   source ~/.bashrc
   ```

### Completion Not Working

1. **Verify completion is loaded**:
   ```bash
   complete -p command_name
   ```

2. **Check completion function**:
   ```bash
   type _command_completion
   ```

3. **Test completion manually**:
   ```bash
   # Type command and press Tab twice
   mycommand <Tab><Tab>
   ```

---

## See Also

- [Technical Documentation](TECHNICAL_DOCUMENTATION.md) - Complete architecture reference
- [Configuration Guide](CONFIGURATION.md) - Configuration options
- [README.md](../README.md) - Quick start guide
