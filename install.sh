
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
    youComplteMeCmd="./install.py --clang-completer"
    if test -n $(which node); then
        youComplteMeCmd=${youComplteMeCmd} --tern-completer
    fi
    if test "$system" != "Darwin"; then
        youComplteMeCmd=${youComplteMeCmd} --system-libclang 
    fi
    $youComplteMeCmd
fi

