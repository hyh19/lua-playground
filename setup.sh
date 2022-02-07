#!/usr/bin/env bash

curl -R -O http://www.lua.org/ftp/lua-5.4.3.tar.gz

tar zxf lua-5.4.3.tar.gz

cd lua-5.4.3

sudo make all install

cd ..

rm -rf lua-5.4.3*

git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime

sh ~/.vim_runtime/install_basic_vimrc.sh
