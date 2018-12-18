eval `ssh-agent -s`
ssh-add

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

alias stt="C:/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
    . /usr/share/bash-completion/completions/git
fi

# If not running interactively: exit immediately.
# Note that 'return' works because the file is sourced, not executed.

if [[ $- != *i* ]] || [ -z "$PS1" ]; then
    return 0
fi

# windows git bash version 3 is too minimal
bashVersionTmp="$(bash --version | grep -v "version 4")"
if [[ "$bashVersionTmp" == *-pc-msys* ]]; then
    . ~/.extra
    return 0
fi
unset bashVersionTmp

############# INCLUDE ####################################

# load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{config_dotfiles,path,load,colors,exports,icons,aliases,bash_complete,functions,extra,dotfilecheck}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

############# SETTINGS ###################################

# enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar cmdhist extglob cdable_vars; do
    shopt -s "$option" 2> /dev/null
done
unset option

# When the command contains an invalid history operation (for instance
# when
# using an unescaped "!" (I get that a lot in quick e-mails and commit
# messages) or a failed substitution (e.g. "^foo^bar" when there was
# no "foo"
# in the previous command line), do not throw away the command line,
# but let me
# correct it.
shopt -s histreedit;

# append to the Bash history file, rather than overwriting it
shopt -s histappend

# rezize the windows-size if needed
shopt -s checkwinsize

# check if the user isn't root
if [ "$UID" != 0 ]; then

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# autocorrect typos in path names when using `cd`
shopt -s cdspell
fi

# Do not autocomplete when accidentally pressing Tab on an
# empty line. (It takes
# forever and yields "Display all 15 gazillion possibilites?")
shopt -s no_empty_cmd_completion;

# Do not overwrite files when redirecting using ">".
# Note that you can still override this with ">|".
#set -o noclobber;

############# EXTRA ####################################

if [ -d $HOME/.redpill ]; then

# define the path from "red-pill"
export REDPILL=$HOME/.redpill

# Which plugins would you like to load? (plugins can
# be found in ~/.redpill/plugins/available/*)
# Example format: plugins=(rails git textmate ruby
# lighthouse)
# Add wisely, as too many plugins slow down shell
# startup.
plugins=$(echo $CONFIG_BASH_PLUGINS | sed 's/(//g' | sed 's/)//g')

  source $HOME/.redpill/redpill-init-bash.sh
fi

function hdrive {
     cd /mnt/h/code
}

function local_code {
    cd /mnt/c/Users/naku0510/local_code
}

alias stt="C:/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"

HISTSIZE=5000
HISTFILESIZE=10000

shopt -s histappend

# Sourch bash-git-prompt
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

# Add node to path
export PATH=$PATH:"/mnt/c/program files/nodejs"
# Add Azure cli
export PATH=$PATH:"/mnt/c/Program Files (x86)/Microsoft SDKs/Azure/CLI2/wbin"
# Add Terraform
export PATH=$PATH:"/mnt/c/terraform"

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

sudo ./mount_drives.sh

local_code
