
#!/bin/bash

eval `ssh-agent -s`
ssh-add
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"

    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
    . /usr/share/bash-completion/completions/git
fi

function code {
    cd ~/code
}

function uidir {
    cd /c/Users/naku0510/Documents/UiPath
}

alias uipath="C:/Program\ Files\ \(x86\)/UiPath/Studio/UiStudio.exe"
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
