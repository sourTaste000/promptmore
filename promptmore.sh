# shellcheck disable=SC2148
# TODO: Add support for other shells
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

extras=""

function node_project_ver() {
    if [ -f "package.json" ]; then
        # test if package.json has a version property
        if [ -n "$(jq -r '.version' package.json)" ]; then
            extras+="on %F{yellow} $(jq -r '.version' package.json)%F{white} using %F{green} $(node -v)%F{white} "
        else
            extras+="on %F{green} Unknown%F{white} using %F{green} $(node -v)%F{white} "
        fi
    fi
    PS1="%K{magenta}%F{black}%~%f%k $extras%(?.%(!.# .➜ ).%(!.%F{red}#%? %F{white}.%F{red}➜%? %F{white}))"
    export PS1
}

function git_project_ver() {
    if [ -d ".git" ]; then
        extras+="via %F{cyan}$(git branch | sed 's/*//')%F{white} "
        if [ -n "$(git status --porcelain)" ]; then
            extras+="with %F{red}$(git status --porcelain | wc -l | xargs)%F{white} uncommitted changes "
        fi
    fi
    PS1="%K{magenta}%F{black}%~%f%k $extras%(?.%(!.# .➜).%(!.%F{red}#%? %F{white}.%F{red}➜%? %F{white})) "
    export PS1
}

function reset() {
    if [ "$OLDPWD" != "$(pwd)" ]; then
        extras=""
        PS1="%K{magenta}%F{black}%~%f%k $extras%(?.%(!.# .➜).%(!.%F{red}#%? %F{white}.%F{red}➜%? %F{white})) "
        export PS1
    fi
}


PS1="%K{magenta}%F{black}%~%f%k %(?.%(!.# .➜ ).%(!.%F{red}#%? %F{white}.%F{red}➜%? %F{white}))"
PS3="select>"
RPROMPT="%* | $(batt_level)"

export PS1
export PS3
export RPROMPT
chpwd_functions+=( reset node_project_ver git_project_ver )
