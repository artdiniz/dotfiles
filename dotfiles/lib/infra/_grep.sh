function _grep_filter {
    grep $@ || test $? = 1
}