curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/bundle -p

sudo apt-get install ctags
sudo apt-get install build-essential cmake python-dev  #编译YCM自动补全插件依赖
sudo apt-get install silversearcher-ag

BASEDIR=$(dirname $0)
cp $BASEDIR/.vimrc  ~/.vimrc
cp $BASEDIR/.vimrc.bundles  ~/.vimrc.bundles
vim -u $HOME/.vimrc.bundles +PlugInstall! +PlugClean! +qall
cd $HOME/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.sh --tern-completer --clang-completer
