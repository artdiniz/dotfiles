function _create_and_write_file {
    local _file_path="$1"
    local _file_dirname="$(dirname "$_file_path")"
    local _file_name="$(basename "$_file_path")"
    
    local _inputed_file_content=""
    while read -r _stdin; do
        _inputed_file_content+="$_stdin\\n"
    done

    # If present, removes newline at the end of file, and then inserts newline at the end
    # This guarantees that there will be always at least one newline at the end of the file
    local _file_content="$(printf "${_inputed_file_content#\\n}\n")"

    $(
        cd "$_file_dirname"
        cat > "$_file_name" <<< "$(printf "$_file_content")"
    )
}
