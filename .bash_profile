if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto verbose"

function _prompt {
    EXIT_CODE="$?"

    BOLD="\[\033[1m\]"
    OFF="\[\033[m\]"

    # Debian default
    PS1="${debian_chroot:+($debian_chroot)}\u@\h \w"

    # git status
    PS1="$PS1$(__git_ps1) $BOLD\$$OFF "

    # always at the leftmost column
    PS1="\[\033[G\]$PS1"
}

PROMPT_COMMAND=_prompt

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/devel/emscripten

export EDITOR=vim

# sort ASCII-wise in ls
export LC_COLLATE="C"

if [ -f ~/devel/_solarized/dircolors-solarized/dircolors.ansi-universal ]; then
    eval `dircolors ~/devel/_solarized/dircolors-solarized/dircolors.ansi-universal`
fi

. /usr/share/autojump/autojump.sh

if [ -f ~/.bash_profile_private ]; then
    . ~/.bash_profile_private
fi
