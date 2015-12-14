# paths
export PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/go"

# xdg
export XDG_CACHE_HOME="$HOME/.fonts"

# env
if [[ $(uname) == "Linux" && $SSH_CONNECTION == "" ]]; then
    export TERM=rxvt-unicode
else
    export TERM=xterm
fi
export EDITOR='vim'

# terminal settings
export LS_COLORS="ow=01;94:di=01;94"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line

# overwrite the zsh git prompt
export ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}!"
export ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[green]%}?"

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

setopt extended_glob
setopt promptsubst
setopt promptpercent
unsetopt auto_cd

# ctrl-x + e = edit your command in vim before running
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line
