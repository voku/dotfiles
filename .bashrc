
#!/bin/bash

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
    . /usr/share/bash-completion/completions/git
fi

function hdrive {
    cd /mnt/h/code
}

function uidir {
    cd /c/Users/naku0510/Documents/UiPath
}

alias stt="C:/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"

HISTSIZE=5000
HISTFILESIZE=10000

shopt -s histappend

# Add node to path
export PATH=$PATH:"/c/program files/nodejs"
# Add Azure cli
export PATH=$PATH:"/c/Program Files (x86)/Microsoft SDKs/Azure/CLI2/wbin"
# Add Terraform
export PATH=$PATH:"/c/terraform"

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"



hdrive

if [[ $- != *i* ]] || [ -z "$PS1" ]; then
    return 0
fi

# try to load global-bashrc
if [ -f /etc/bashrc ]; then
      . /etc/bashrc
fi

source ~/.bash_profile

