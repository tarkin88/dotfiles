#! /bin/env bash

if ! command -v stow &> /dev/null
then
    echo "GNU Stow is not installed"
    exit
fi

echo 'Stowing dotfiles...'

if [ ! -d "${HOME}/.i3" ]; then
    stow -vSt ~ i3
    echo 'i3'
else
    echo 'backup i3 directory first'
fi
