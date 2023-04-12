if [ -r /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    . /usr/local/etc/bash_completion.d/git-prompt.sh

    #unstaged (*) and staged (+) changes will be shown next to the branch name.
    GIT_PS1_SHOWDIRTYSTATE=true

    # if there're untracked files, a '%' will be shown next to the branch name
    GIT_PS1_SHOWUNTRACKEDFILES=false
``
    GIT_PS1_STATESEPARATOR=" "

    export PS1="\e[38;5;45m\u\e[0m\e[38;5;7m@\e[0m\e[38;5;84m\h\e[0m\e[38;5;7m:\e[0m\e[38;5;8m\W\e[38;5;15m\$(__git_ps1) \e[0m\e[38;5;201m\\n\$\e[0m\e[38;5;15m \e[0m"
else
    export PS1="\e[38;5;45m\u\e[0m\e[38;5;7m@\e[0m\e[38;5;84m\h\e[0m\e[38;5;7m:\e[0m\e[38;5;8m\W \e[0m\e[38;5;201m\\n\$\e[0m\e[38;5;15m \e[0m"
fi