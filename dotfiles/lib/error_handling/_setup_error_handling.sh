#!/usr/bin/env bash

set -ueE -o pipefail

function _trap_exit {
	_exit_code=$1
	_lineno=$2

	if _function_exists '_onexit'; then
		_onexit $_exit_code $_lineno
	fi
}

function _trap_err {
	_exit_code=$1
	_lineno=$2

	echo
	echo "Exception on line $_lineno. Exit code $_exit_code" 
	echo "ERROR HANDLING"
	echo "======"
	if _function_exists '_onerror'; then
		_onerror $_exit_code $_lineno
	fi

	exit $_exit_code
}

function _trap_interruption {
	_exit_code=$1
	_lineno=$2
	
	echo
	echo "INTERRUPTED" 
	echo "======"
	if _function_exists '_oninterrupt'; then
		_oninterrupt $_exit_code $_lineno
	fi

	exit $_exit_code
}

trap "_trap_exit \$? \$LINENO" EXIT
trap "_trap_err \$? \$LINENO" ERR
trap "_trap_interruption \$? \$LINENO" SIGINT SIGHUP