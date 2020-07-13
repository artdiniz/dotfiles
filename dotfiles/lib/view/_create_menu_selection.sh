#!/usr/bin/env bash

function _create_menu_selection {
    local _selected_item_var_name
	_selected_item_var_name="$1"

    local _menu_data
	IFS='' read -rd '' _menu_data || [ $? -eq 1 ] && :

    less -XRF < <(
        while IFS= read -r _item_name; do
            if printf %s "$_item_name" | grep -e '^    > ' >/dev/null ; then
                printf '\n|___%s' "$(printf %s "$_item_name" | sed -e 's/^    > //')"
            else
                printf '\n\n# %s' "$_item_name"
            fi
        done < <(printf %s "$_menu_data")
    )
}