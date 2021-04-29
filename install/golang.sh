#!/usr/bin/env zsh

# Start
echo "golang.sh starting."

# Install Homebrew
[[ ! -f $(brew --prefix asdf)/asdf.sh ]] && echo "Unable to find asdf binary" && exit 1

asdf plugin add golang
asdf plugin update golang

# Install and update plugins
versions=(
    "1.16"
)

for i in "${versions[@]}"
do
    asdf install golang ${i}
    asdf reshim golang ${i}
done

asdf global golang 1.16

# Finished
echo "$(basename "$0") complete."
