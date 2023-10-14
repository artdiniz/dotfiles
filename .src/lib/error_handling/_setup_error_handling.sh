#!/usr/bin/env bash

if [ ${_DOTFILES_STRICT_MODE:-"1"} == '1' ]; then
	set -ueE -o pipefail
fi

if [ -z "${_trap_stack_position:-}" ]; then
	_trap_stack_position=0
fi
export _trap_stack_position=$((_trap_stack_position + 1))

function _throw {
	_code=${1:-1}
	_message="${2:-""}"
	if [ ! -z "$_message" ]; then
		_log printf "$(_style "[ERROR]" $_text_red $_bold) %s\n\n" "$_message"
	fi
	return $_code
}

function _trap_exit {
	_exit_code=$1
	_lineno=$2
	_script=$3
	_script_params=${@:4}

	if _function_exists '_onexit'; then
		_onexit $_exit_code $_lineno $_script $_script_params
	fi
}

function _trap_err {
	_exit_code=$1
	_lineno=$2
	_script=$3
	_script_params=${@:4}

	printf "error stack |$_trap_stack_position| exit code $_exit_code at $_script:$_lineno\n"
	if [ $_trap_stack_position -eq 1 ]; then
		echo "error stack |@| exit code $_exit_code"
	fi

	if _function_exists '_onerror'; then
		_onerror $_exit_code $_lineno $_script $_script_params
	fi

	exit $_exit_code
}

function _trap_interruption {
	_exit_code=$1
	_lineno=$2
	_script=$3
	_script_params=${@:4}
	
	if [ $_trap_stack_position -eq 1 ]; then
		echo
		echo "INTERRUPTED" 
		echo "======"
	fi
	if _function_exists '_oninterrupt'; then
		_oninterrupt $_exit_code $_lineno $_script $_script_params
	fi

	exit $_exit_code
}

trap '_trap_err $? $LINENO $0 $@' ERR
trap '_trap_interruption $? $LINENO $0 $@' SIGINT SIGHUP
trap '_trap_exit $? $LINENO $0 $@' EXIT
