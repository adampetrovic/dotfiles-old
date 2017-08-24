# Start
echo "atom.sh starting."

# Install Homebrew
[[ ! -f /usr/local/bin/apm ]] && echo "Unable to find Atom Package Manager"

# Upgrading existing packages
apm upgrade -c false

# Install packages
apps=(
    atom-beautify
    autocomplete-python
    file-icons
    go-debug
    go-plus
    platformio-ide-terminal
    vim-mode-plus
)

apm install "${apps[@]}"
apm clean

# Finished
echo "$(basename "$0") complete."
