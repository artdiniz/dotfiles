# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
_line_break=$'\n'
export PS1="%F{14}%n@%M%f:%F{08}%0~%f$_line_break%F{13}%(!.#.$)%f "
