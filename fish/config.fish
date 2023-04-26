set -g -x TERM xterm-256color
# xterm

# environment path
set PATH "/usr/local/bin" "$HOME/.toolbox/bin" "$HOME/.cargo/bin" $PATH

# locale seems to be important
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# having JAVA_HOME is nice
# set -xg JAVA_HOME (/usr/libexec/java_home) # for default JVM
set -xg JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_231.jdk/Contents/Home

# Android config
set -xg ANDROID_SDK_ROOT $HOME/Library/Android/sdk


# Make sure directory colors are readable in ls
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# AWS credentials
# set -xg AWS_ACCESS_KEY_ID AKIAI3NZZDSLWDTPFDEQ
# set -xg AWS_SECRET_ACCESS_KEY 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

#########################
# Language Environments
#########################

# load rbenv
source $HOME/.config/fish/rbenv.fish
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null

# Add Android SDK to path
set PATH /Library/Android/bin $PATH

# load pyenv
set -g -x PYENV_ROOT $HOME/.pyenv
set PATH $PYENV_ROOT/shims $PATH
status --is-interactive; and . (pyenv init - | psub)

# load nodenv
status --is-interactive; and source (nodenv init -|psub)

# node JS path
# node/npm setup
set NODE_PATH $HOME/node_modules /usr/local/lib/node_modules

# assumes vpn-onetouch is in ~/.local/bin
# https://w.amazon.com/bin/view/Users/hqzhang/VPNOneTouch/
set PATH $HOME/.local/bin $PATH

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
set -g -x EDITOR nvim

# set -g -x APP_ENV dev

# misc apps/frameworks/languages configuration
set -g -x GOPATH $HOME/go

# less coloring configuration
set -g -x LESS '-R'
# set -g -x LESSOPEN '|~/.lessfilter %s'

# add go path
set PATH $GOPATH/bin $PATH

# predefine certain aliases
source $HOME/.config/fish/aliases.fish

# load VCS stuff
# source $HOME/.config/fish/git.fish

# Android
set PATH $HOME/Library/Android/sdk/platform-tools $PATH


# load aws keys
# source $HOME/.config/fish/aws.fish

# load some environment variables
# source $HOME/.config/fish/vars.fish

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
    # git_prompt

    echo ' $ '
end

function whowas
    /usr/bin/ldapsearch -x -LLL -h ldap.amazon.com -b 'o=amazon.com' "(uid=$argv)" cn description
end

# oribi devenv setting
# launchctl setenv DEVENV_HOST 10.200.10.1
# set -xg DEVENV_HOST 10.200.10.1

# direnv integration
direnv hook fish | source
