test _is_macos || exit 1

# Based on https://apple.stackexchange.com/questions/259093/can-touch-id-for-the-mac-touch-bar-authenticate-sudo-users-and-admin-privileges/306324#306324

# From TLDP page about PAM (Pluggable Authentication Modules): http://tldp.org/HOWTO/User-Authentication-HOWTO/x115.html
_sudo_pamd_file_path="/etc/pam.d/sudo"

# macOS PAM modules folder from: https://coderwall.com/p/s67djq/learn-about-pam-authentication
_pam_modules_path="/usr/lib/pam/"
_touchid_pam_module_name="pam_tid.so"

function _has_touch_id {
	ls "$_pam_modules_path" | grep -q "$_touchid_pam_module_name"
	return $?
}


function _is_sudo_touch_id_enabled {
	cat "$_sudo_pamd_file_path" | grep -q "$_touchid_pam_module_name"
	return $?
}

if ! _has_touch_id; then
	printf "%s\n" "Touch ID auth is not supported in this machine."
	exit
fi

if _is_sudo_touch_id_enabled; then
	printf "%s\n" "Sudo is already using Touch ID. Skipping..." 
	exit
fi

if _confirm "Detected Touch ID auth support. Do you want to enable Touch ID when running sudo?" "n"; then
	_temp_sudo_pam_file="$(mktemp)"

	cat - > "$_temp_sudo_pam_file" <<-NEW_SUDO_PAM
	$(head -n1 "$_sudo_pamd_file_path")
	$(printf "auth       sufficient     pam_tid.so\n")
	$(tail -n+2 "$_sudo_pamd_file_path")
	NEW_SUDO_PAM

	printf "Now we need admin privileges to change \'$_sudo_pamd_file_path\' to this:\n\n"
	_box "$(cat "$_temp_sudo_pam_file")" "– |" "1"
	
	printf "\n"
	if _confirm "Continue?" "n"; then
		printf "%s\n" "Activating sudo with Touch ID..."
		cp "$_sudo_pamd_file_path" ~/Desktop
		sudo -k mv "$_temp_sudo_pam_file" "$_sudo_pamd_file_path"
		printf "%s\n" "If everything worked you should be prompted to use Touch ID now."
		sudo -k printf "%s\n" "Success"
	fi
else
	printf "%s\n" "Skipping setup sudo with Touch ID"
fi
