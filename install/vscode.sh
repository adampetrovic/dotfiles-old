# Start
echo "vscode.sh starting."

# Install Homebrew
[[ ! -f /usr/local/bin/code ]] && echo "Unable to find VS Code binary"

# Install packages
extensions=(
    "ms-vscode.Go"
    "vscodevim.vim"
    "eamodio.gitlens"
    "ms-python.python"
)

for i in "${extensions[@]}"
do
    code --force --install-extension "${i}"
done

# Finished
echo "$(basename "$0") complete."
