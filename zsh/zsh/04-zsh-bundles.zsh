# start with tmux by default
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_ITERM2=false

antigen bundles <<EOBUNDLES
    copybuffer
    git
    jira
    pip
    python
    sudo
    tmux
    tmuxinator

    skx/sysadmin-util
EOBUNDLES

bindkey "^R" history-incremental-search-backward
bindkey "^N" history-incremental-search-forward
