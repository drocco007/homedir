# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -1F'
alias m='mount | rg -v "/sys|/proc|tmpfs|devpts|mqueue|hugetlbfs" | sed "s/ (.*)$//"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias eo='exo-open'

alias tmux='tmux -2'
alias icat='~/.local/kitty.app/bin/kitten icat'

alias cal='cal | GREP_COLORS="ms=38;5;231;48;5;243" grep --color -EC6 "\b$(date +%e | sed "s/ //g")"'

# git aliases

alias gl='git log --graph --decorate'
alias gla='git log --all --graph --decorate'
alias glb='git log --graph --decorate --patch master^..'  # patch view of this branch
alias grup='git remote update -p'
alias s='git -c color.status=always status -s | rg -v "\?\?.* \.\."'

# Cursor editor
alias code='/tmp/.mount_Cursor*/usr/bin/cursor --no-sandbox -r '



# fzf cd

function __fzf_cd_find__ ()
{
    fd --type d --follow --exclude .git --exclude venv --exclude node_modules --exclude __pycache__ "$@" | sed "s|^$HOME|~|"
}

export -f __fzf_cd_find__

function __c__ ()
{
    local dir;
    dir=$(
        __fzf_cd_find__ | fzf --height=40% --preview='tree -C {}' --bind '~:reload(__fzf_cd_find__ . ~)+clear-query'
    ) && printf 'builtin cd -- %q' "$(builtin unset CDPATH && builtin cd -- "${dir/#\~/$HOME}" && builtin pwd)"
}

function c () {
    `__c__`
}


# weather

function w () {
    ~/source/sandbox/opencode/atlanta-weather.sh "$@"
}



# pass

function pass () {
    args="$@"

    if [ -z "$args" ] ; then
        sel=$(fd --type f --exclude 2fa . .password-store | cut --complement -c-16 | sed 's/\.gpg$//' | fzf) && pass "$sel"
    else
        /usr/bin/pass "$@"
    fi
}


#
# set the active client, which adjusts the behavior of certain commands
# (e.g. ,snapdb)
#

,set_client() {
    if [ -z $1 ];
    then
        echo -n > ~/.client
    else
        echo $1 > ~/.client
    fi

    tmux refresh-client -S
}


#
# set the active AWS profile, which adjusts the behavior aws commands

,profile () {
    profile_exists=$(echo "$1" | comm -12 ~/.aws_profile_cache -)

    if [ ! "$profile_exists" ]; then
        >&2 echo -e "\e[31mERROR: \e[0mno such profile $1"
        return
    fi

    echo -n "$1" >~/.aws_profile

    tmux refresh-client -S
}

_comma_profile_complete () {
  COMPREPLY=($(rg "(^$2|-$2|$2\$)" ~/.aws_profile_cache));
}

complete -F _comma_profile_complete ",profile"

#
#

,ssm () {
    target=${1%%,*}

    shift

    command="$@"

    if [ -z "$command" ] ; then
        command='["bash -l"]'
    fi

    aws_bin --profile $(< ~/.aws_profile) ssm start-session \
        --target "$target" \
        --document-name AWS-StartInteractiveCommand \
        --parameters command="$command"
}

_comma_ssm_complete () {
    COMPREPLY=($(awless ls instances --columns id,name --format csv --no-headers | tr ' ' _ | rg -i "$2"))
}

complete -F _comma_ssm_complete ",ssm"


# Push a file to an attached Android device, and request that the
# device's MediaStore add the new file to it's database
#     https://stackoverflow.com/a/19435985
beam () {
  adb push $1 /storage/emulated/legacy/Download/ && \
  adb shell am broadcast \
    -a android.intent.action.MEDIA_MOUNTED \
    -d file:///storage/emulated/legacy/$(basename $1)
}

,dip () {
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
}

_comma_docker_ip_complete () {
    COMPREPLY=($(docker ps --format '{{.Names}}' | grep -i "$2"))
}

complete -F _comma_docker_ip_complete ",dip"
