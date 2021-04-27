#!/usr/bin/env zsh

# Start
echo "ssh-keys.sh starting."

PROFILE="unknown"
if [[ -f "/tmp/.dotfiles-profile" ]]; then
    PROFILE="$(cat /tmp/.dotfiles-profile)"
fi

eval "$(op signin my)"

# downloading ssh key
case "$PROFILE" in
"work")
    echo "Downloading work SSH key from 1password"
    OP_UUID=$(op list items | jq -r '.[] | select(.overview.title == "Atlassian - SSH Key") | .uuid')

    rm -f $HOME/.ssh/id_rsa.work* || true
    op get document ${OP_UUID} > $HOME/.ssh/id_rsa.work
    # make sure we have strict permissions on our keyfiles
    chmod 600 $HOME/.ssh/id_rsa.work
    # generate public key file
    PASSPHRASE=$(op get item ${OP_UUID} | jq -r '.details.sections[].fields[]? | select(.t == "passphrase") | .v')
    ssh-keygen -y -P ${PASSPHRASE} -f $HOME/.ssh/id_rsa.work > $HOME/.ssh/id_rsa.work.pub
    ;;
esac


OP_UUID=$(op list items | jq -r '.[] | select(.overview.title == "Personal - SSH Key") | .uuid')
PASSPHRASE=$(op get item ${OP_UUID} | jq -r '.details.sections[].fields[]? | select(.t == "passphrase") | .v')
rm -f $HOME/.ssh/id_rsa.personal* || true
# save personal ssh key
op get document ${OP_UUID} > $HOME/.ssh/id_rsa.personal
# make sure we have strict permissions on our keyfiles
chmod 600 $HOME/.ssh/id_rsa.personal
# generate public key file
ssh-keygen -y -P ${PASSPHRASE} -f $HOME/.ssh/id_rsa.personal > $HOME/.ssh/id_rsa.personal.pub

# Finished
echo "$(basename "$0") complete."
