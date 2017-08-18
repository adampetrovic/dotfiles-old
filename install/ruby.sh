#!/usr/bin/env bash

echo "ruby.sh starting."

if [[ -f "/usr/local/bin/rbenv" ]] ; then
    eval "$(rbenv init -)"

    # install ruby versions
    rbenv install 2.0.0-p598

    # set the global version
    rbenv global 2.0.0-p598

    # install gems
    rbenv exec gem install tmuxinator

    rbenv rehash
else
    echo "ERROR: rbenv is not available."
    exit 1
fi
