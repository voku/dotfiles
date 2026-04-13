
# load composure first, so we support function metadata
source "${REDPILL}/lib/composure.bash"

# support 'plumbing' metadata
cite _about _param _example _group _author _version

if [[ $SYSTEM_TYPE != "CYGWIN" && $SYSTEM_TYPE != "MINGW" ]]; then
  SCM_CHECK=false
  SCM_GIT_SHOW_DETAILS=false
fi

# load colors first so they can be use in base theme
source "${REDPILL}/themes/colors.theme.bash"
source "${REDPILL}/themes/base.theme.bash"

# library
lib="${REDPILL}/lib/*.bash"
for config_file in $lib; do
  source $config_file
done
unset lib

source "${REDPILL}/plugins/available/base.plugin.bash"

# load all of the aliases, completion, plugins that were defined in ~/.config_dotfiles
for plugin in ${plugins[@]}; do
  for file_type in "aliases" "completion" "plugins"; do
    file_type_single=$(echo $file_type | sed 's/plugins/plugin/g')

    if [ -f "${REDPILL}/${file_type}/available/${plugin}.${file_type_single}.bash" ]; then
      source "${REDPILL}/${file_type}/available/${plugin}.${file_type_single}.bash"
    fi
  done
done

# load active aliases, completion, plugins (only for backward compatible)
for file_type in "aliases" "completion" "plugins"; do
  file_type_single=$(echo $file_type | sed 's/plugins/plugin/g')

  if [ -f "${REDPILL}/${file_type}/enabled/${plugin}.${file_type_single}.bash" ]; then
    source "${REDPILL}/${file_type}/enabled/${plugin}.${file_type_single}.bash"
  fi
done

# load custom aliases, completion, plugins
for file_type in "aliases" "completion" "plugins"; do
  if [ -e "${REDPILL}/${file_type}/custom.${file_type}.bash" ]; then
    source "${REDPILL}/${file_type}/custom.${file_type}.bash"
  fi
done

# custom
custom="${REDPILL}/custom/*.bash"
for config_file in $custom; do
  if [ -e "${config_file}" ]; then
    source $config_file
  fi
done

# prompt
# Explicitly set __GIT_PROMPT_DIR_BASH so gitprompt.sh does not have to rely
# on BASH_SOURCE[0] resolution, which can fail in some bash environments
# (e.g. when switching from zsh to bash, or inside WSL). See issue #38.
export __GIT_PROMPT_DIR_BASH="${REDPILL}/bash_prompt"
source "${REDPILL}/bash_prompt/gitprompt.sh"

unset file_type
unset file_type_single
unset plugin
unset custom
unset config_file

if [[ $PROMPT ]]; then
  export PS1="\["$PROMPT"\]"
fi

