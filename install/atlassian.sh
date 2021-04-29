#!/usr/bin/env zsh

# Start
echo "atlassian.sh starting."

echo "starting atlas installation w/ plugins"
# Check atlas-cli is installed
[[ ! -f $(brew --prefix atlas-cli)/bin/atlas ]] && echo "Unable to find atlas-cli binary" && exit 1

atlas plugin update

plugins=(
    "micros"
    "asap"
    "packages"
    "shipyard"
    "slauth"
    "statlas"
)

for i in "${plugins[@]}"
do
    atlas plugin install -n ${i}
done

atlas upgrade
# Finished
echo "$(basename "$0") complete."
