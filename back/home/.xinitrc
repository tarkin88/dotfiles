#!/bin/bash
# Set variables for the locations of the system and user Xresources and Xmodmap files
sysresources=/etc/X11/xinit/Xresources
userresources=$HOME/.Xresources
userprofile=$HOME/.xprofile

# Set the wallpaper using wal
# wal -R &
# setxkbmap us &

# Start the compositor (picom) with experimental backends enabled
# picom --experimental-backends &

# Start dunst
# dunst &

# Start dwmblocks
# dwmblocks &

# Start clipmenud
# clipmenud &


# Set the keyboard layout
# setxkbmap us &

# Check if sysresources and sysmodmap exist
if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

# Check if userresources exist
if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$userprofile" ]; then
    source "$userprofile"
fi
# Run ssh-agent and dwm in an infinite loop
 # while :; do
 #  ssh-agent dwm 
 # done

# Execute dwm
exec dbus-launch bspwm
# exec dbus-launch --sh-syntax --exit-with-session dwm 2> ~/.dwm.log
