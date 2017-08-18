# Start
echo "brew.sh starting."

# Install Homebrew
[[ ! -f /usr/local/bin/brew ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

# Install packages

apps=(
    cmake
	ctags
    coreutils
	diff-so-fancy
    dockutil
    ffmpeg
    fasd
	ghq
	git
	git-flow
	git-when-merged
	glide
	go
    gnu-sed --with-default-names
    grep --with-default-names
    httpie
    imagemagick
    jq
	keychain
    mackup
    peco
    psgrep
	pyenv
	pyenv-virtualenv
	pyenv-virtualenvwrapper
	pyenv
    python
	python3
	rbenv
	reattach-to-user-namespace
	sift
    ssh-copy-id
	sudolikeaboss
    tmux
    tree
    vim
    wget
	yarn
	youtube-dl
)

brew install "${apps[@]}"

# install additional completion files
brew install docker-compose-completion
brew install pip-completion
brew install tmuxinator-completion

# cleanup unneeded files
brew cleanup

# Finished
echo "$(basename "$0") complete."
