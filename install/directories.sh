#!/usr/bin/env bash

# Start
echo "directories.sh starting."

# create folders
[[ ! -d ~/Pictures/screenshots ]] && mkdir -p ~/Pictures/screenshots
[[ ! -d ~/code ]] && mkdir -p ~/code
[[ ! -d ~/tmp ]] && mkdir -p ~/tmp

# Finished
echo "$(basename "$0") complete."
