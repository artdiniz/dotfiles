# https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
_line_break=$'\n'
_f=$'\e[0m'
_f_white=$'\e[38;5;7m'
_f_grey=$'$_f\e[38;5;8m'
_f_default=$'\e[38;5;15m'
_f_cyan=$'\e[38;5;45m'
_f_green=$'\e[38;5;84m'
_f_magenta=$'\e[38;5;201m'

if [ -r /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    . /usr/local/etc/bash_completion.d/git-prompt.sh

    #unstaged (*) and staged (+) changes will be shown next to the branch name.
    GIT_PS1_SHOWDIRTYSTATE=true

    # if there're untracked files, a '%' will be shown next to the branch name
    GIT_PS1_SHOWUNTRACKEDFILES=false

    GIT_PS1_STATESEPARATOR=" "

    export PS1="$_f_cyan\u$_f_white@$_f_green\h$_f_white:$_f_grey\W$_f_magenta\$(__git_ps1) \\n\$$_f "
else
    export PS1="$_f_cyan\u$_f_white@$_f_green\h$_f_white:$_f_grey\W$_f_magenta\\n\$$_f "
fi