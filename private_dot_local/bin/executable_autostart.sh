#!/bin/sh

function restart {
	if ps x | rg "$1" | awk '{print $1}'; then
		pkill -f $1
	fi
	$1 $2 $3 $4 &
}

source ~/.xprofile &
xrdb ~/.Xresources &
restart dunst
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
dbus-update-activation-environment --all &
restart dbus-launch --sh-syntax
feh --bg-fill ~/Pictures/Wallpapers/Rose/rose_pine_maze.png &
# betterlockscreen -w &
greenclip daemon &
# bash ~/.local/bin/status_updater.sh &
slstatus &
# compfy --daemon
picom --daemon &
udiskie -a &
xset -dpms
xset s 840 900 # dim at 14 min and lock at 15 min
xss-lock -n ~/.local/bin/notify-suspend -- betterlockscreen -l dimblur &

