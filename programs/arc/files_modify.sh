if _is_macos; then
    _settings_path="$HOME/Library/Application Support/Arc/User Data"
else
    : # TODO add _settings_path when Arc becomes available in other platforms
fi

_create_string_var _profiles_and_names <<-VAR
	$(
		ls -l1 "$_settings_path" | _grep_filter -E 'Default|Profile' | while read -r; do
			_profile_folder="$REPLY"
			_preferences_json="$(cat "$_settings_path/$_profile_folder/Preferences")"
			_profile_name="$(_json_utils read-parsed "$_preferences_json" "profile.name")"
			echo "${_profile_folder} | ${_profile_name}"
		done
	)
VAR

IFS=$'\n' _select "Select the profiles you want to copy preferences from" "$_profiles_and_names" | while read -r; do
	_selected_profile_and_name="$REPLY"
	_selected_profile_folder="$(printf "$_selected_profile_and_name" | awk -F' [|] ' '{print $1}')"
	_selected_profile_name="$(printf "$_selected_profile_and_name" | awk -F' [|] ' '{print $2}')"
	
	_log echo "==== Selected profile: $_selected_profile_name"

	echo "$_settings_path/$_selected_profile_folder/Preferences.devtools.preferences.customEmulatedDeviceList.json"
done
