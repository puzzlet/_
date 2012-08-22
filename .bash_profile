export PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$"
export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w `git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`\[\033[37m\]$\[\033[00m\] '

export PS1="\[\033[G\]$PS1"

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/devel/emscripten

export EDITOR=vim

eval `dircolors ~/devel/_solarized/dircolors-solarized/dircolors.ansi-universal`

. /usr/share/autojump/autojump.sh
