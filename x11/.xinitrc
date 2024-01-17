#!/bin/sh
unclutter & # Mouse hider
nitrogen --restore & # Wallpaper

# Statusbar script
while true; do
	xsetroot -name "$(date "+%h %d %H:%M")"
	sleep 10
done &

# set your own coordinates for redshift
# redshift -l

xcompmgr & # Compositor
fcitx -d & # Input method engine for Japanese
udiskie & # Automatic disk mounting daemon
dunst & # Notification daemon
exec dwm # dwm
