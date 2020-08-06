#!/usr/bin/env zsh

# Start
echo "ssh-keys.sh starting."

source install/1password.sh

PROFILE="unknown"
if [[ -f "/tmp/.dotfiles-profile" ]]; then
    PROFILE="$(cat /tmp/.dotfiles-profile)"
fi

# downloading ssh key
case "$PROFILE" in
"work")
    echo "Downloading Atlassian SSH key from 1password"
    OP_UUID="g6jq64b6vjgfjgs6s4hmucfrly"

    rm -f ~/.ssh/id_rsa.atlassian
    op get document ${OP_UUID} > $HOME/.ssh/id_rsa.atlassian
    chmod 600 $HOME/.ssh/id_rsa.atlassian
    ;;
esac


OP_UUID="k4byzx4zizhpnchktv6ojsiw5e"
rm -f ~/.ssh/id_rsa.personal
op get document ${OP_UUID} > $HOME/.ssh/id_rsa.personal
chmod 600 $HOME/.ssh/id_rsa.personal

# Finished
echo "$(basename "$0") complete."
