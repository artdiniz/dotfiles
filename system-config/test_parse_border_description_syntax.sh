_border_a='3(_\\\)(_\\\)*)(alo)'
_border_b='\'
_border_c='\ \'
_border_a='3(_\\\)(_\\\)*)(alo)'

_create_string_var _border_descriptions <<-BORDER_DESCRIPTIONS
	$_border_a
	$_border_b
	$_border_c
	_*_•
	2(_*_•
	2_*_•)
	\s
	|\s|
BORDER_DESCRIPTIONS

while IFS= read -r _description; do
	_result_border=''
	_command="_parse_border_description_syntax '$_description' _result_border"
	eval "$_command"

	printf \\n"$(_style \$ $_text_red) $(_style %s $_bold)"\\n\\n%s\\n\\n "$_command" "$_result_border"
done <<<"$(printf '%s' "$_border_descriptions")"
