# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    if [ -f ~/devel/_/vendor/dircolors-solarized/dircolors.ansi-universal ]; then
        eval `dircolors ~/devel/_/vendor/dircolors-solarized/dircolors.ansi-universal`
    fi

    alias ls='ls --color=auto'
    alias cgrep='grep --color=auto'
    alias less="less -R"
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto verbose"

function _prompt {
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    EXIT_CODE="$?"

    BOLD="\[\033[1m\]"
    OFF="\[\033[m\]"

    C1="\[\033[0;38m\]"
    BLUE="\[\033[0;34m\]"
    BROWN="\[\033[0;33m\]"

    # Debian default
    PS1="${debian_chroot:+($debian_chroot)}\u@\h $BLUE\w$OFF"

    # git status
    command -v __git_ps1 2>&1 && PS1="$PS1$BROWN$(__git_ps1)$OFF"

    PS1="$PS1$BROWN$(hg prompt "({branch} {status}{update}) " 2>/dev/null)$OFF"

    PS1="$OFF$PS1$BOLD\$$OFF "

    # always at the leftmost column
#    PS1="\[\033[G\]$PS1"
}

PROMPT_COMMAND=_prompt

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/devel/emscripten

export EDITOR=vim

# sort ASCII-wise in ls
export LC_COLLATE="C"

[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh

# colored grep and less
alias grep="grep --color=always"
alias less="less -R"

if [ -f ~/.bash_profile_private ]; then
    . ~/.bash_profile_private
fi
