# https://stackoverflow.com/questions/2829613/how-do-you-tell-if-a-string-contains-another-string-in-posix-sh

function _string_contains {
    string="$1"
    substring="$2"
    if [ "${string#*$substring}" != "$string" ]; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

function _string_starts_with {
    string="$1"
    substring="$2"
    if [ "${string#$substring}" != "$string" ]; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

function _string_ends_with {
    string="$1"
    substring="$2"
    if [ "${string%$substring}" != "$string" ]; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}
