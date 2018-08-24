#!/usr/bin/env bash

echo "python.sh starting."

if [[ -f "/usr/local/bin/pyenv" ]] ; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # install python versions
    echo "installing python versions..."
    pyenv install 2.7.15 
    pyenv install 3.7.0

    # set the global version
    pyenv global 3.7.0

    pyenv rehash

else
    echo "ERROR: pyenv is not available."
    exit 1
fi
