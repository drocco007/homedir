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
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias eo='exo-open'

alias tmux='tmux -2'

# git aliases

alias gl='git log --graph --decorate'
alias gla='git log --all --graph --decorate'
alias glb='git log --graph --decorate --patch master^..'  # patch view of this branch
alias grup='git remote update -p'

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
