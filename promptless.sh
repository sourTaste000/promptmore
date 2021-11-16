# shellcheck disable=SC2148
# This script is written for ZSH, which is not supported by shellcheck
# To use this prompt, you must use a Nerd Font in your terminal, which can be downloaded here: https://www.nerdfonts.com/font-downloads
# TODO: Add support for other shells, support multiple 'extras', eg. displaying the git branch ad the node project version at the same time
function batt_level() {
    level=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    if [ "$level" -lt 10 ]; then
        echo " $level"
    elif [ "$level" -lt 20 ]; then
        echo " $level"
    elif [ "$level" -lt 30 ]; then
        echo " $level"
    elif [ "$level" -lt 40 ]; then
        echo " $level"
    elif [ "$level" -lt 50 ]; then
        echo " $level"
    elif [ "$level" -lt 60 ]; then
        echo " $level"
    elif [ "$level" -lt 70 ]; then
        echo " $level"
    elif [ "$level" -lt 80 ]; then
        echo " $level"
    elif [ "$level" -lt 90 ]; then
        echo " $level"
    else
        echo " $level"
    fi
}

function node_project_ver() {
    extras=""
    if [ -f "package.json" ]; then
        # test if package.json has a version property
        if [ -n "$(jq -r '.version' package.json)" ]; then
            extras="on %F{yellow} $(jq -r '.version' package.json)%F{white} using %F{green} $(node -v)%F{white} "
        else
            extras="on %F{green} Unknown%F{white} using %F{green} $(node -v)%F{white} "
        fi
    fi
    PS1="%F{blue}%~%F{white} $extras%(?.%(!.# .➜ ).%(!.%F{red}# %F{white}.%F{red}➜ %F{white}))"
    export PS1
}

function git_project_ver() {
    extras=""
    if [ -d ".git" ]; then
        extras="on %F{cyan}$(git branch | sed 's/*//')%F{white} "
    fi
    PS1="%F{blue}%~%F{white} $extras%(?.%(!.# .➜ ).%(!.%F{red}# %F{white}.%F{red}➜ %F{white}))"
    export PS1
}

precmd_functions+=( git_project_ver node_project_ver )

PS1="%F{blue}%~%F{white} %(?.%(!.# .➜ ).%(!.%F{red}# %F{white}.%F{red}➜ %F{white}))"
PS3="select>"
RPROMPT="%* | $(batt_level)"

export PS1
export PS3
export RPROMPT
