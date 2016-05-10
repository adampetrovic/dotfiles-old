alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias ack-grep="sift"
alias ag="sift"
alias cpv="rsync -pogr --progress"
alias claer="clear"
alias sl="ls"
alias da="deactivate"
alias tmux="tmux -2"
alias t="task"

gkill() { ps aux | grep "$*" | awk '{print $2}' | sudo xargs kill -9; }
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
