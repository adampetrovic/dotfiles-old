#!/usr/bin/env zsh

# Start
echo "ssh-keys.sh starting."

PROFILE="unknown"
if [[ -f "/tmp/.dotfiles-profile" ]]; then
    PROFILE="$(cat /tmp/.dotfiles-profile)"
fi

# downloading ssh key
case "$PROFILE" in
"work")
    echo "Downloading Atlassian SSH key from 1password"
    OP_UUID=$(. bin/1p list items | jq -r '.[] | select(.overview.title == "Atlassian - SSH Key") | .uuid')

    rm -f $HOME/.ssh/id_rsa.atlassian* || true
    . bin/1p get document ${OP_UUID} > $HOME/.ssh/id_rsa.atlassian
    # make sure we have strict permissions on our keyfiles
    chmod 600 $HOME/.ssh/id_rsa.atlassian
    # generate public key file
    PASSPHRASE=$(. bin/1p get item ${OP_UUID} | jq -r '.details.sections[].fields[]? | select(.t == "passphrase") | .v')
    ssh-keygen -y -P ${PASSPHRASE} -f $HOME/.ssh/id_rsa.atlassian > $HOME/.ssh/id_rsa.atlassian.pub
    ;;
esac


OP_UUID=$(. bin/1p list items | jq -r '.[] | select(.overview.title == "Personal - SSH Key") | .uuid')
PASSPHRASE=$(. bin/1p get item ${OP_UUID} | jq -r '.details.sections[].fields[]? | select(.t == "passphrase") | .v')
rm -f $HOME/.ssh/id_rsa.personal* || true
# save personal ssh key
. bin/1p get document ${OP_UUID} > $HOME/.ssh/id_rsa.personal
# make sure we have strict permissions on our keyfiles
chmod 600 $HOME/.ssh/id_rsa.personal
# generate public key file
ssh-keygen -y -P ${PASSPHRASE} -f $HOME/.ssh/id_rsa.personal > $HOME/.ssh/id_rsa.personal.pub

# Finished
echo "$(basename "$0") complete."