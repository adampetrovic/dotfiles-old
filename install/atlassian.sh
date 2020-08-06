#!/usr/bin/env zsh

# Start
echo "atlassian.sh starting."

# Check atlas-cli is installed
[[ ! -f $(brew --prefix atlas-cli)/bin/atlas ]] && echo "Unable to find atlas-cli binary" && exit 1

atlas plugin update
atlas plugin install -n micros
atlas upgrade

# Finished
echo "$(basename "$0") complete."
