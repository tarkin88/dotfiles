#!/bin/sh
# Install script for dusk and dependenecies
echo "Installing dependencies"
sudo pacman -S base-devel git libx11 libxcb libxinerama libxft imlib2 yajl --noconfirm

# clone dmenu flexipatch, copy his config files and build
echo "Cloning and building dmenu-flexipatch"
git clone https://github.com/bakkeby/dmenu-flexipatch.git dmenu --depth 1
cp configs/dmenu/* dmenu/
cd dmenu
make
sudo make clean install
cd ..

# clone dmenu dusk, copy his config files and build
echo "Cloning and building dusk"
git clone https://github.com/bakkeby/dusk.git --depth 1
cp configs/dusk/* dusk/
cd dusk
make
sudo make clean install
cd ..

# install extras
echo "installing extras"
sudo pacman -S alacritty ranger atool w3m ueberzug unrar unzip highlight bat fzf fish pulsemixer playerctl --noconfirm
echo "Done"
