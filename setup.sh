#! /bin/env bash

if ! command -v stow &> /dev/null
then
    echo "GNU Stow is not installed"
    exit
fi

echo 'Stowing dotfiles...'

stow -vSt ~ home
echo 'Home stowed'
stow -vSt ~/.config config
echo 'config stowed'
