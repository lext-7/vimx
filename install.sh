
#!/bin/bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/bundle -p

system=$(uname)

if test "$1" != "--simple-mode"; then
    if test "$system" = "Darwin"; then
        brew install ctags the_silver_searcher cmake
    else
        sudo apt install ctags build-essential cmake python-dev silversearcher-ag clang -y
    fi
fi

BASEDIR=$(dirname $0)
cp $BASEDIR/.vimrc  ~/.vimrc
if test "$1" = "--simple-mode"; then
    cp $BASEDIR/.vimrc.simple.bundles  ~/.vimrc.bundles
else
    cp $BASEDIR/.vimrc.bundles  ~/.vimrc.bundles
fi

vim -u $HOME/.vimrc.bundles +PlugInstall! +PlugClean! +qall
cd $HOME/.vim/bundle/YouCompleteMe

if test "$1" != "--simple-mode"; then
    if test -z $(which node); then
        ./install.py --clang-completer --system-libclang
    else
        ./install.py --tern-completer --clang-completer --system-libclang
    fi
fi
