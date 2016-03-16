#!/bin/sh

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew dependencies
# TODO: sort these out
brew install \
    android-sdk \
    apktool \
    autoconf \
    automake \
    bash \
    boost \
    brew-cask \
    chromedriver \
    cmake \
    cscope \
    ctags \
    emacs \
    findutils \
    fish \
    gdbm \
    gettext \
    git \
    git-flow \
    go \
    gradle \
    highlight \
    htop-osx \
    icu4c \
    jq \
    libevent \
    libsass \
    libtool \
    lua \
    macvim \
    mysql \
    neovim \
    node \
    oniguruma \
    openssl \
    pcre \
    phantomjs \
    pkg-config \
    pyenv \
    pypy \
    python \
    ranger \
    readline \
    reattach-to-user-namespace \
    s3cmd \
    sassc \
    sonar \
    sonar-runner \
    sqlite \
    ssh-copy-id \
    the_silver_searcher \
    tidy \
    tidyp \
    tmux \
    tree \
    unar \
    vim \
    wget \
    xz

# copy config files
cp .gitconfig ~/.gitconfig
cp .githelpers ~/.githelpers
cp .vimrc ~/.vimrc
cp .pylintrc ~/.pylincrc
cp .tmux.conf ~/.tmux.conf

# copy fish files
mkdir -p ~/.config/fish
cp fish/*.fish ~/.config/fish

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# run vim plug installations and exit
vim +PlugInstall +PlugUpdate +PlugUpgrade +qall
