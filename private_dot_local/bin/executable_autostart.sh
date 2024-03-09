#!/bin/bash
xrandr --output eDP-1 --off --output HDMI-1 --mode 2560x1440 --pos 0x0 --rotate normal &

function restart {
	if ps x | rg "$1" | awk '{print $1}'; then
		pkill -f $1
	fi
	$1 $2 $3 $4 &
}

restart dbus-launch --sh-syntax
restart dunst
restart betterlockscreen -w
restart compfy
eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
greenclip daemon &

xset -dpms
xset s 840 900 # dim at 14 min and lock at 15 min
xss-lock -n ~/.local/bin/notify-suspend -- betterlockscreen -l dimblur &
sleep 2s
restart udiskie -as
bash -c ~/.local/bin/status-updater.sh &

if [ -f "$HOME/.local-machine" ]; then
	source "$HOME/.local-machine"
fi

notify-send "Welcome Back" &
