_parse_border_description_syntax '3(_\\\\)(_\\\*)(alo)' _border_list

_parse_border_description_syntax '_*_•' _simple_border

_parse_border_description_syntax '2(_*_•' _simple_border

_parse_border_description_syntax '2_*_•)' _simple_border

_parse_border_description_syntax '\' _simple_border

printf %s\\n  "Multiple"
while IFS= read -r _border; do
	printf %s\\n "$_border oi"
done <<<"$(printf %b "$_border_list")"

printf \\n%s\\n "Simple"
while IFS= read -r _border; do
	printf %s\\n "$_border"
done <<<"$(printf "$_simple_border")"