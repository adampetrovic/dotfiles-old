eval `keychain --eval -q $(find ~/.ssh/ -type f | grep -v -e pub -e authorized_keys -e config -e known_hosts -e pem) 2> /dev/null`
