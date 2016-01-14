eval `keychain --eval -q $(find $HOME/.ssh/* -type f | grep -v -e pub -e authorized_keys -e config -e known_hosts -e README -e master -e pem)`
