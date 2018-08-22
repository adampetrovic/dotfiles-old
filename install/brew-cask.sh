# Start
echo "brew-cask.sh starting."

# install caskroom
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts
brew tap buo/cask-upgrade

# install packages
apps=(
    1password
    adobe-creative-cloud
    appcleaner
    atom
    bartender
    caffeine
    etcher
    google-drive-file-stream
    google-chrome
    iterm2
    istat-menus
    private-internet-access
    snip
    spectacle
    spotify
    telegram
    torbrowser
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzip webpquicklook suspicious-package && qlmanage -r

# install fonts
fonts=(
    font-source-code-pro
    font-source-code-pro-for-powerline

)

brew cask install "${fonts[@]}"

# cleanup unneeded files
brew cask cleanup
