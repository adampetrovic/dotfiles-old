#!/usr/bin/env zsh

# Start
echo "python.sh starting."

# Install Homebrew
[[ ! -f $(brew --prefix asdf)/asdf.sh ]] && echo "Unable to find asdf binary" && exit 1

asdf plugin add python
asdf plugin update python

# Install and update plugins
versions=(
    "3.8.5"
)

for i in "${versions[@]}"
do
    asdf install python ${i}
    asdf reshim python ${i}
done

asdf global python 3.8.5

# Finished
echo "$(basename "$0") complete."
