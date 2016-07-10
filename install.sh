curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/bundle -p

if ! [[ "$1" == "--simple-mode" ]]; then
    sudo apt install ctags build-essential cmake python-dev silversearcher-ag llvm
fi

BASEDIR=$(dirname $0)
cp $BASEDIR/.vimrc  ~/.vimrc
cp $BASEDIR/.vimrc.bundles  ~/.vimrc.bundles
vim -u $HOME/.vimrc.bundles +PlugInstall! +PlugClean! +qall
cd $HOME/.vim/bundle/YouCompleteMe

if ! [[ "$1" == "--simple-mode" ]]; then
    if [ -z $(which node) ]; then
        ./install.sh --clang-completer --system-libclang
    else
        ./install.sh --tern-completer --clang-completer --system-libclang
    fi
fi
