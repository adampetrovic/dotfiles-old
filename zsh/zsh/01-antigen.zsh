if [[ ! -e $HOME/.antigen.zsh ]]; then
    git clone https://github.com/zsh-users/antigen.git $HOME/.antigen.zsh
fi

if [[ -e $HOME/.antigen.zsh ]]; then
    source $HOME/.antigen.zsh/antigen.zsh
    antigen use oh-my-zsh

    # theme
    antigen theme clean

    # zsh-users utilities
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-history-substring-search

    antigen apply
fi
