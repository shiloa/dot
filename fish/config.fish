# xterm
set -g -x TERM screen-256color

# environment path
set PATH "/usr/local/bin" $PATH

# locale seems to be important
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# having JAVA_HOME is nice
set -x -g JAVA_HOME (/usr/libexec/java_home)

#########################
# Language Environments
#########################

# load rbenv
source $HOME/.config/fish/rbenv.fish
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# load pyenv
set -g -x PYENV_ROOT $HOME/.pyenv
set PATH $PYENV_ROOT/shims $PATH
status --is-interactive; and . (pyenv init - | psub)

# load nodenv
status --is-interactive; and source (nodenv init -|psub)

# node JS path
# node/npm setup
set NODE_PATH $HOME/node_modules /usr/local/lib/node_modules

#########################
# Global Vars
#########################

# Kubernetes config
# set -xg KUBECONFIG $HOME/admin.conf
# set -xg KOPS_STATE_STORE "s3://[PATH]"

# ansible environment setup
# set -x -g ANSIBLE_VAULT_PASSWORD_FILE $HOME/.ansible/password.txt
# set -x -g ANSIBLE_PRIVATE_KEY_FILE $HOME/.ssh/oribiappio.pem

# AWS credentials
# set -xg AWS_ACCESS_KEY_ID [AWS_ACCESS_KEY_ID]
# set -xg AWS_SECRET_ACCESS_KEY [AWS_SECRET_ACCESS_KEY]

# vim is the preferred editor
set -g -x EDITOR vim

# set -g -x APP_ENV dev

# misc apps/frameworks/languages configuration
set -g -x GOPATH $HOME/gocode

# less coloring configuration
set -g -x LESS '-R'
# set -g -x LESSOPEN '|~/.lessfilter %s'

# add go path
set PATH $GOPATH/bin $PATH

# predefine certain aliases
source $HOME/.config/fish/aliases.fish

# load VCS stuff
source $HOME/.config/fish/git.fish

# load aws keys
# source $HOME/.config/fish/aws.fish

# load some environment variables
source $HOME/.config/fish/vars.fish

source $HOME/.config/fish/fzf.fish

function current_time
    printf '%s' (date +%H:%M)
end

function fish_prompt
    set_color normal
    printf '%s ' (current_time)

    set_color purple
    printf '%s' (prompt_pwd)
    set_color normal

    # hg_prompt
    git_prompt

    echo ' $ '
end

# oribi devenv setting
# launchctl setenv DEVENV_HOST 10.200.10.1
# set -xg DEVENV_HOST 10.200.10.1

