function _log {
    "$@" 1>&2
}

function _dotfiles_session_log {
    "$@" 1>&2 > "$DOTFILES_HOME/session.log" 
}
