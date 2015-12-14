alias ag="ag --silent"
alias ack-grep="ag"
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias cpv="rsync -pogr --progress"
alias claer="clear"
alias sl="ls"
alias da="deactivate"
alias scrot="scrot -e 'mv \$f ~/screenshots/'"
alias tmux="tmux -2"
alias t="task"

gkill() { ps aux | grep "$*" | awk '{print $2}' | sudo xargs kill -9; }
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
