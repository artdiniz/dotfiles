#!/usr/bin/env bash

set -eE -o pipefail

_has_already_run=1
function _catch_error() {
    local _command="$1"
    local _line_number="$2"
    local _status_code="$3"

    if [ $_status_code -gt 0 ] && [ $_has_already_run -eq 1 ]; then
        printf "$(tput setab 1)$(tput setaf 7)$(tput bold) %s $(tput sgr0) status code %s at %s:%s\\n\\n" \
            "Error" "$_status_code" "$_command" "$_line_number"
    fi

    _has_already_run=0
    exit $_status_code
}

trap '_catch_error $BASH_SOURCE $LINENO $?' ERR
trap '_catch_error $BASH_SOURCE $LINENO $?' EXIT

