#!/usr/bin/env bash
set -u

_SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_program_name="$1"

"$_SCRIPT_DIR"/exec.sh "programs/$_program_name/postinstall.sh"
