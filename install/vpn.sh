#!/bin/bash
sudo -v

export OP_SESSION_my="$(eval op signin my adam@petrovic.com.au --output=raw)"

echo "Fetching VPN credentials from 1password"
OP_UUID=$(op list items | jq -r '.[] | select(.overview.title == "Home VPN") | .uuid')
VPN_ADDR=$(op get item ${OP_UUID} | jq -r '.details.sections[].fields[]? | select(.n == "url") | .v')
VPN_USERNAME=$(op get item $OP_UUID | jq -r '.details.sections[].fields[]? | select(.n == "username") | .v')
VPN_PPP_PASSWORD=$(op get item $OP_UUID | jq -r '.details.sections[].fields[]? | select(.n == "password") | .v')
VPN_SHARED_SECRET=$(op get item $OP_UUID | jq -r '.details.sections[].fields[]? | select(.n == "1698BB2BDC374E84B0BDA9E2CDA85753") | .v')


echo "Creating VPN"
sudo macosvpn create --force --l2tp "Home VPN" --endpoint ${VPN_ADDR} --username ${VPN_USERNAME} --password ${VPN_PPP_PASSWORD} --shared-secret ${VPN_SHARED_SECRET}


echo "Adding VPN ip-up script"
sudo touch /etc/ppp/ip-up
cat <<EOF >> /etc/ppp/ip-up
#!/bin/sh
# remove the default 10/22 route to default back to ppp0
/sbin/route delete -net 10/22 -interface en0
EOF
sudo chmod +x /etc/ppp/ip-up
