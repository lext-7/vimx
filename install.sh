curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/bundle -p
BASEDIR=$(dirname $0)
cp $BASEDIR/.vimrc  ~/.vimrc
cp $BASEDIR/.vimrc.bundles  ~/.vimrc.bundles
vim -u $HOME/.vimrc.bundles +PlugInstall! +PlugClean! +qall
$HOME/.vim/bundle/YouCompleteMe/install.sh --all
# cp $BASEDIR/.vimrc  ~/.vimrc
# cp $BASEDIR/.vimrc.bundles  ~/.vimrc.bundles
