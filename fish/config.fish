# xterm
set -g -x TERM xterm-256color

# environment path
set PATH "/usr/local/bin" $PATH

# load rbenv
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# node JS path
# node/npm setup
set NODE_PATH $HOME/node_modules /usr/local/lib/node_modules /usr/local/share/npm/lib/node_modules
set PATH /usr/local/share/npm/bin $PATH

# load pyenv
# set -g -x PYENV_ROOT $HOME/.pyenv
# set PATH $PYENV_ROOT/bin $PATH
status --is-interactive; and . (pyenv init -|psub)

# export docker toolbox settings
set -x DOCKER_TLS_VERIFY "1";
set -x DOCKER_HOST "tcp://192.168.99.100:2376";
set -x DOCKER_CERT_PATH "/Users/shilo/.docker/machine/machines/default";
set -x DOCKER_MACHINE_NAME "default";

# vim is the preferred editor
set -g -x EDITOR vim

set -g -x APP_ENV dev

# misc apps/frameworks/languages configuration
set -g -x GOPATH $HOME/gocode

# less coloring configuration
set -g -x LESS '-R'
set -g -x LESSOPEN '|~/.lessfilter %s'

# set PATH $GOPATH/bin $SCALA_ROOT/bin $CLOJURE_ROOT/bin $APP_PATH/bin $PATH
set PATH $GOPATH/bin /usr/local/lib/node_modules/bin $PATH

# predefine certain aliases
source $HOME/.config/fish/aliases.fish

# load VCS stuff
source $HOME/.config/fish/hg.fish
source $HOME/.config/fish/git.fish
source $HOME/.config/fish/rbenv.fish

# load aws keys
source $HOME/.config/fish/aws.fish

# load some server connection definitions
source $HOME/.config/fish/qservers.fish

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

    hg_prompt
    git_prompt

    echo ' $ '
end
