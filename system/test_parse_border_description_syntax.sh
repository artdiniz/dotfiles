_parse_border_description_syntax '3(_\\\))(_*)(alo) ' _border_list

_parse_border_description_syntax '_*_•' _simple_border

echo  "Multiple"
while IFS= read -r _border; do
	printf "%s\n" "$_border"
done <<<"$(printf "$_border_list")"

echo

echo  "Simple"
while IFS= read -r _border; do
	printf "%s\n" "$_border"
done <<<"$(printf "$_simple_border")"