_texto =""

read -d '' -r _texto <<-ARQUIVO
	Alô alô W Brasil
	Jacarezinho
	Avião
	Cuidado com o disco voador
ARQUIVO

printf "\n$(_style '$' $_text_red) $(_style '%s' $_bold)\n%s\n\n" \
	'_box $_texto' \
	"$(_box "$_texto")" \
\
	'_box "$_texto" – |" 1' \
	"$(_box "$_texto" "– |" 1)"\
\
	'_box "$_texto" "*" "0 2"' \
	"$(_box "$_texto" "*" "0 2")" \
\
	'_box "$_texto" "* |" "1 2 5"' \
	"$(_box "$_texto" "* |" "1 2 5")" \
\
	'_box "$_texto" "* | •" "1 2 5 5"' \
	"$(_box "$_texto" "* | •" "1 2 5 5")" \
\
	'_box "$_texto" "* « • »" "1 2"' \
	"$(_box "$_texto" "* « • »" "1 2")" \
\
	'_box "$_texto" "_* || •+" "1 2 5 5"' \
	"$(_box "$_texto" "_* || •–" "1 2 5 5")" \
