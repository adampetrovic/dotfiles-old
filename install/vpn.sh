#!/bin/bash
sudo -v

echo "Fetching VPN credentials from 1password"
OP_UUID=$(. bin/1p list items | jq -r '.[] | select(.overview.title == "Home VPN") | .uuid')
VPN_ADDR=$(. bin/1p get item ${OP_UUID} | jq -r '.details.sections[].fields[]? | select(.t == "URL") | .v')
VPN_USERNAME=$(. bin/1p get item $OP_UUID | jq -r '.details.sections[].fields[]? | select(.t == "username") | .v')
VPN_PPP_PASSWORD=$(. bin/1p get item $OP_UUID | jq -r '.details.sections[].fields[]? | select(.t == "PPP password") | .v')
VPN_SHARED_SECRET=$(. bin/1p get item $OP_UUID | jq -r '.details.sections[].fields[]? | select(.t == "pre-shared secret") | .v')

echo "Creating VPN"
sudo macosvpn create --force --l2tp "Home VPN" --endpoint ${VPN_ADDR} --username ${VPN_USERNAME} --password ${VPN_PPP_PASSWORD} --sharedsecret ${VPN_SHARED_SECRET}
