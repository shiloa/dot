# xterm
set -g -x TERM screen-256color

# environment path
set PATH "/usr/local/bin" $PATH

# locale seems to be important
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# locale seems to be important
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# You should have java installed
set -x -g JAVA_HOME (/usr/libexec/java_home)

# load rbenv (OPTIONAL, requires 'brew install rbenv')
# set PATH $HOME/.rbenv/bin $PATH
# set PATH $HOME/.rbenv/shims $PATH
# rbenv rehash >/dev/null ^&1
# source $HOME/.config/fish/rbenv.fish

# node JS path (OPTIONAL, requires 'brew install node')
# node/npm setup
# set NODE_PATH $HOME/node_modules /usr/local/lib/node_modules

# load pyenv (OPTIONAL, requires 'brew install pyenv')
# set -g -x PYENV_ROOT $HOME/.pyenv
# set PATH $PYENV_ROOT/bin $PATH
# status --is-interactive; and . (pyenv init -|psub)

# vim is the preferred editor (duh)
set -g -x EDITOR vim

# misc apps/frameworks/languages configuration (OPTIONAL, requires 'brew install go')
# set -g -x GOPATH $HOME/gocode
# set PATH $GOPATH/bin $PATH

# less coloring configuration
set -g -x LESS '-R'
set -g -x LESSOPEN '|~/.lessfilter %s'

# predefine certain aliases (if you wish)
source $HOME/.config/fish/aliases.fish

# load VCS stuff
source $HOME/.config/fish/git.fish
# source $HOME/.config/fish/hg.fish


# load aws keys
# source $HOME/.config/fish/aws.fish

# load some server connection definitions (OPTIONAL)
# source $HOME/.config/fish/credentials.fish

# fzf (fuzzy find anything) support (OPTIONAL, 'brew install fzf')
# source $HOME/.config/fish/fzf.fish


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
