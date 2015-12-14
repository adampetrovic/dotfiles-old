export VIRTUALENVWRAPPER_PYTHON=`which python2 || which python`
export VIRTUALENVWRAPPER_VIRTUALENV=`which virtualenv`
export WORKON_HOME=$HOME/.virtualenvs
mkdir -p $WORKON_HOME
source `which virtualenvwrapper.sh`
