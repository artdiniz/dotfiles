if type brew &>/dev/null; then
    export HOMEBREW_GITHUB_API_TOKEN="4ea2769601de687158f92dc22208b1f2013ae369"
    export PATH="/usr/local/sbin:$PATH"

    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
        [[ -r "$COMPLETION" ]] && source "$COMPLETION"
        done
    fi
fi