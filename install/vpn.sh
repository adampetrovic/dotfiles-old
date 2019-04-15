#!/bin/bash
sudo -v

source install/op.sh
NAME="Home VPN"

echo "Fetching VPN credentials from 1password"
OP_UUID=$(op list items | jq -r '.[] | select(.overview.title == "${NAME}") | .uuid')
VPN_ADDR=$(op get item nifseeyhh5bydlhl4dyoqq5bey | jq -r '.details.sections[].fields[]? | select(.n == "url") | .v')
VPN_USERNAME=$(op get item nifseeyhh5bydlhl4dyoqq5bey | jq -r '.details.sections[].fields[]? | select(.n == "username") | .v')
VPN_PPP_PASSWORD=$(op get item nifseeyhh5bydlhl4dyoqq5bey | jq -r '.details.sections[].fields[]? | select(.n == "password") | .v')
VPN_SHARED_SECRET=$(op get item nifseeyhh5bydlhl4dyoqq5bey | jq -r '.details.sections[].fields[]? | select(.n == "1698BB2BDC374E84B0BDA9E2CDA85753") | .v')

echo "Creating VPN"
sudo macosvpn create --force --l2tp ${NAME} --endpoint ${VPN_ADDR} --username ${VPN_USERNAME} --password ${VPN_PPP_PASSWORD} --shared-secret ${VPN_SHARED_SECRET}
