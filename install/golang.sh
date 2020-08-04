#!/usr/bin/env zsh

# Start
echo "golang.sh starting."

# Install Homebrew
[[ ! -f $(brew --prefix asdf)/asdf.sh ]] && echo "Unable to find asdf binary" && exit 1

asdf plugin add golang
asdf plugin update golang

# Install and update plugins
versions=(
    "1.13"
    "1.13.14"
    "1.14"
    "1.14.6"
)

for i in "${versions[@]}"
do
    asdf install golang ${i}
    asdf reshim golang ${i}
done

asdf global golang 1.14.6

# Finished
echo "$(basename "$0") complete."
