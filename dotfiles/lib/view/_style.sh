#!/bin/bash -e

# Check the post by @jafrog to understand this better: http://jafrog.com/2013/11/23/colors-in-terminal.html


_bold="1"
_underline="4"

_text_black="30"
_text_red="31"
_text_green="32"
_text_yellow="33"
_text_blue="34"
_text_purple="35"
_text_cyan="36"
_text_white="37"
_text_grey="38;5;242"

_bg_black="40"
_bg_red="41"
_bg_green="42"
_bg_yellow="43"
_bg_blue="44"
_bg_purple="45"
_bg_cyan="46"
_bg_white="47"

_style_reset="\e[0m"

function _style {
    local _text="$1"

    local _styles=""
    while read -r style_number; do
		  _styles="$_styles$style_number;"
    done <<<"$(printf "%s\n" "${@:2}")"

    _styles="\e[${_styles%%;}m"

    printf "%b%s%b" "$_styles" "$_text" "$_style_reset"
}
