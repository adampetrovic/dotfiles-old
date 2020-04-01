export AWSPATH=$HOME/.aws

function awsenv {
    source $AWSPATH/mvenv.sh $1
}

function _aws_envs {
    reply=($(ls $AWSPATH))
}

compctl -K _aws_envs aws

if [[ -f "${HOME}/.config/cloudtoken/bashrc_additions" ]]; then
    source "${HOME}/.config/cloudtoken/bashrc_additions"
fi
