_texto=""

_create_string_var _texto <<-'ARQUIVO'
	Alô alô W Brasil
	Jacarezinho
	Avião
	Cuidado com o disco voador
ARQUIVO

_backlash_border='2(\\)(\\) 2(|)(|)'
_bug_complex_backlash_border='2(\\)(\\•\\) 2(|)(|)'
_bug_another_complex_backlash_border='2(\\\\)(\\) 2(|)(|)'
_create_string_var _commands <<-COMMANDS
	_box "\$_texto"
	_box "" 1 "\$_texto"
	_box "– |" 1 "\$_texto"
	_box "2(_)(-) 2(|)(|) 2(–)(¯)" 1 "\$_texto"
	_box "*" "0 2" "\$_texto"
	_box "* |" "1 2 5" "\$_texto"
	_box "* | •" "1 2 5 5" "\$_texto"
	_box "* « • »" "1 2" "\$_texto"
	_box "|*| -|•|-" "1 2 5 5" "\$_texto"
	_box "_* |" "1 2 5 5" "\$_texto"
	_box "≈_* -•| •+¯ |O" "1 2 5 5" "\$_texto"
	_box "•" "\$(_box "•" "\$(_box "•" "1 2" "\$_texto")")"
	_box "2(_)(_*) -•| 2(•+)(¯) 2(|-)(|•)" "1 2 5 5" "\$_texto"
	_box "2(_)(_*) 2(-•|)(-) 2(•+)(¯) 2(|-)(|•)" "1 2 5 5" "\$_texto"
	_box '\' '1 2 5 5' "\$_texto"
	_box '$_backlash_border' '1 2 5 5' "\$_texto"
	_box '$_bug_complex_backlash_border' '1 2 5 5' "\$_texto"
	_box '$_bug_another_complex_backlash_border' '1 2 5 5' "\$_texto"
	_box "°øo0Oº°" "1 2 5 5" "\$_texto"
	_box "-\*" "1 2 5 5" "\$_texto"
COMMANDS

while IFS= read -r _command; do
	printf \\n"$(_style \$ $_text_red) $(_style %s $_bold)"\\n\\n%s\\n\\n\\n "$_command" "$(eval "$_command")"
done <<< "$(printf '%b' "$_commands")"
