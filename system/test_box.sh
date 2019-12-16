_texto=""

read -d '' -r _texto <<-ARQUIVO
	Alô alô W Brasil
	Jacarezinho
	Avião
	Cuidado com o disco voador
ARQUIVO

_commands=(
	'_box "$_texto"'
	'_box "$_texto" "– |" 1'
	'_box "$_texto" "2(_)(-) 2(|)(|) 2(–)(¯)" 1'
	'_box "$_texto" "*" "0 2"'
	'_box "$_texto" "* |" "1 2 5"'
	'_box "$_texto" "* | •" "1 2 5 5"'
	'_box "$_texto" "* « • »" "1 2"'
	'_box "$_texto" "|*| -|•|-" "1 2 5 5"'
	'_box "$_texto" "_* |" "1 2 5 5"'
	'_box "$_texto" "≈_* -•| •+¯ |O" "1 2 5 5"'
	'_box "$(_box "$(_box "$_texto" "•" "1 2")" "•")" "•"'
	'_box "$_texto" "2(_)(_*) -•| 2(•+)(¯) 2(|-)(|•)" "1 2 5 5"'
	'_box "$_texto" "2(_)(_*) 2(-•|)(-) 2(•+)(¯) 2(|-)(|•)" "1 2 5 5"'
	'_box "$_texto" "°øo0Oº°" "1 2 5 5"'
)

for _command in "${_commands[@]}"; do
	printf "\n$(_style "$" $_text_red) $(_style "%s" $_bold)\n\n%s\n\n\n" "'$_command'" "$(eval "$_command")"
done

# $ _box "$_texto" "2(_)(_*) -•| 2(•+)(¯) 2(|-)(|•)" "1 2 5 5"
#
#       _________________________________
#       _*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_ 
#     ||                                 -
#     -•     Alô alô W Brasil            •
#     ||     Jacarezinho                 |
#     -•     Avião                       -
#     ||     Cuidado com o disco voador  •
#     -•                                 |
#     ||                                 -
#     -•                                 •
#     ||                                 |
#     -•                                 -
#       •+•+•+•+•+•+•+•+•+•+•+•+•+•+•+•+• 
#       ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
