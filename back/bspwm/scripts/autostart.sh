#!/bin/bash

autorandr -c &
sleep 1s
xrdb ~/.Xresources &
pgrep -x sxhkd >/dev/null || sxhkd &
pgrep -x dunst >/dev/null || dunst &
pgrep -x polybar >/dev/null || polybar main &
pgrep -x clipmenud >/dev/null || clipmenud &
pgrep -x nm-applet >/dev/null || nm-applet &
pgrep -x picom >/dev/null || picom --experimental-backends &
wal -R &
xset r rate 350 20 &
xsetroot -cursor_name left_ptr &
