function _c1_grep {
    grep "$@" || test $? = 1
}