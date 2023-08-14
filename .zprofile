eval "$(/opt/homebrew/bin/brew shellenv)"
# xterm

export TERM=xterm-256color

# environment path
export PATH=/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# locale seems to be important
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# having JAVA_HOME is nice
# export JAVA_HOME=(/usr/libexec/java_home) # for default JVM
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home

# Make sure directory colors are readable in ls
#export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

#########################
# Language Environments
#########################

# load pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# load nodenv
export PATH=$HOME/.nodenv/bin:$PATH
eval "$(nodenv init -)"

# node JS path
# node/npm setup
export NODE_PATH=$HOME/node_modules:/usr/local/lib/node_modules

# load rbenv
# TODO if needed

#########################
# Global Vars
#########################

# vim is the preferred editor
export EDITOR=lvim

# less coloring configuration
export LESS='-R'

#########################
# Aliases
#########################
alias vi='lvim'
