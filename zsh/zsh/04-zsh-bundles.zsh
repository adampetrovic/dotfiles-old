# start with tmux by default
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_ITERM2=false

antigen bundles <<EOBUNDLES
    copybuffer
    extract
    git
    golang
    jira
    pipenv
    python
    sudo
    tmux
    tmuxinator
    vi-mode

    skx/sysadmin-util
EOBUNDLES
