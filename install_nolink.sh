#!/bin/bash

REPO="~/.vim"

if [ $# -ne 0 ]; then
    REPO="$1"
fi

git -C "$REPO" submodule update --init
mkdir ~/.vim/autoload 
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
