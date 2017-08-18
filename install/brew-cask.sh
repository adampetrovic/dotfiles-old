# Start
echo "brew-cask.sh starting."

# install caskroom
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts

# install packages
apps=(
    1password
    alfred
    caffeine
    charles
    dash
    dbvisualizer
    dropbox
    google-drive
    google-chrome
    google-chrome-canary
    iterm2
    istat-menus
    paw
    private-internet-access
    sketch
    sourcetree
    spectacle
    spotify
    sublime-text
    telegram
    tor-browser
    vlc
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webpquicklook suspicious-package && qlmanage -r

# install fonts
fonts=(
    font-source-code-pro
    font-source-code-pro-for-powerline

)

brew cask install "${fonts[@]}"

# cleanup unneeded files
brew cask cleanup
