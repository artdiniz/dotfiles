# OS detection as in https://github.com/cowboy/dotfiles/blob/504d32679975edb66633e0c3b53244af3772a232/bin/dotfiles

function _is_macos {
  [[ "$OSTYPE" =~ ^darwin ]] || return 121
}

function _is_ubuntu {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 122
}

function _is_ubuntu_desktop {
  dpkg -l ubuntu-desktop >/dev/null 2>&1 || return 123
}

function _get_os {
  for os in macos ubuntu ubuntu_desktop; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}
