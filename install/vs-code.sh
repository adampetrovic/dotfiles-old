# Start
echo "vscode.sh starting."

# Install Homebrew
[[ ! -f /usr/local/bin/code ]] && echo "Unable to find VS Code binary"

# Install packages
extensions=(
    "ms-vscode.Go"
    "vscodevim.vim"
)

code --force --install-extension "${extensions[@]}"

# Finished
echo "$(basename "$0") complete."
