
#TODO remove this when backup sh reads from files_*.sh automatically

_SCRIPT_PATH="$(_get_script_path)"

_json_string="$(cat '/Users/art/Library/Application Support/Arc/User Data/Profile 1/Preferences')"
_json_partial="$(_json_utils read "$_json_string" "devtools.preferences.customEmulatedDeviceList")"

mkdir -p "$_SCRIPT_PATH/backup/"

_json_utils read-parsed -b "$_json_partial" > "$_SCRIPT_PATH/files/Preferences.devtools.preferences.customEmulatedDeviceList.json"