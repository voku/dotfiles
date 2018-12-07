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

# function code {
#     cd ~/code
# }

function uipath {
    cd /c/Users/naku0510/Documents/UiPath
}

alias stt="C:/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"

source ~/.bashrc
