_border_a='3(_\\\)(_\\\)*)(alo)'
_border_b='\'
_border_c='\ \'
_border_a='3(_\\\)(_\\\)*)(alo)'

_create_string_var _clockwise_test_values <<-BORDER_DESCRIPTIONS
	1
	1 2
	1 2 3
	1 2 3 4
	
	a\sb 0
	a\sb c\sd 0
	a\sb c\sd e\sf
BORDER_DESCRIPTIONS

while IFS= read -r _clockwise_values; do
	a=''
	b=''
	c=''
	d=''
	_command="_clock_wise_set_values '$_clockwise_values' a b c d"
	eval "$_command"

	printf \\n"$(_style \$ $_text_red) $(_style %s $_bold)"'\n\ntop: "%s" right: "%s" bottom: "%s" left: "%s"\n\n\n' "$_command" "$a" "$b" "$c" "$d"
done <<<"$(printf '%s' "$_clockwise_test_values")"
