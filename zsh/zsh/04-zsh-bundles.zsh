# start with tmux by default
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_ITERM2=false

antigen bundles <<EOBUNDLES
    git
    git-flow
    unixorn/git-extra-commands
    git-extras
    pip
    python
    sudo
    tmux
    vi-mode
    web-search
EOBUNDLES

bindkey "^R" history-incremental-search-backward
bindkey "^N" history-incremental-search-forward
