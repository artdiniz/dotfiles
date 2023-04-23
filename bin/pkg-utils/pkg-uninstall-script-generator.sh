#!/usr/bin/env bash
set -ueE -o pipefail

_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

while read -r; do
	_pkg_name="$REPLY"

	if [ -z "$_pkg_name" ]; then
		printf 'No package selected\n'
		continue
	fi

	_generated_script_path="$_SCRIPT_DIR/uninstall.$_pkg_name.sh"
	if pkgutil --pkg-info $_pkg_name >/dev/null; then
		:
	else
		continue
	fi

	rm -f "$_generated_script_path"
	cat > "$_generated_script_path" <<-GENERATED_SCRIPT
		#!/usr/bin/env bash
		set -ueE -o pipefail

	GENERATED_SCRIPT

	_volume="$(pkgutil --pkg-info $_pkg_name | grep 'volume: ' | awk '{print $2}')"
	_location="$(pkgutil --pkg-info $_pkg_name | grep 'location: ' | awk '{print $2}')"
	_path="$(printf "${_volume%%/}/${_location%%/}")"

	_files="$(pkgutil  --only-files --files $_pkg_name | xargs -I%% echo ${_path%%/}/%%)"
	_dirs="$(pkgutil  --only-dirs --files $_pkg_name | tail -r | xargs -I%% echo ${_path%%/}/%%)"

	printf "=== $_pkg_name @$_path\n"

	while read -r; do
		_pkg_file="$(printf "$REPLY" | awk '{$1=$1};NF')"
		if [ -z "$_pkg_file" ] || [ ! -e "$_pkg_file" ]; then
			printf "    MISS $REPLY\n"
			continue
		fi

		printf "    FILE $_pkg_file\n"

		printf "rm -f $_pkg_file\n" >> "$_generated_script_path"
	done <<-PKGFILES
		$_files
	PKGFILES

	while read -r; do
		_pkg_dir="$(printf "$REPLY" | awk '{$1=$1};NF')"
		if [ -z "$_pkg_dir" ] || [ ! -e "$_pkg_dir" ]; then
			printf "    MISS $REPLY\n"
			continue
		fi

		printf "    DIR  $_pkg_dir\n"
		printf "rmdir $_pkg_dir\n" >> "$_generated_script_path"
	done <<-PKGDIRS
		$_dirs
	PKGDIRS

	printf "pkgutil --forget $_pkg_name\n" >> "$_generated_script_path"

done <<-PKGS
	$(	
		_selection=""
		select _pkg_id in $(pkgutil --pkgs) "CONTINUE"; do
			if [ "$_pkg_id" = "CONTINUE" ]; then
				break
			fi
			_selection="$_selection$_pkg_id\n"
		done

		printf "$_selection"
	)
PKGS
