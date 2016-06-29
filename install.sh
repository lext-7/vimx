curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/bundle -p

sudo apt install ctags build-essential cmake python-dev silversearcher-ag

BASEDIR=$(dirname $0)
cp $BASEDIR/.vimrc  ~/.vimrc
cp $BASEDIR/.vimrc.bundles  ~/.vimrc.bundles
vim -u $HOME/.vimrc.bundles +PlugInstall! +PlugClean! +qall
cd $HOME/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
if [ -z $(which node) ]; then
    ./install.sh --clang-completer
else
    ./install.sh --tern-completer --clang-completer
fi
