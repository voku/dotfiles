eval `ssh-agent -s`
ssh-add

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

function uipath {
    cd /c/Users/naku0510/Documents/UiPath
}

alias stt="C:/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"

source ~/.bashrc
