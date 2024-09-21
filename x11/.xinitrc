# programs
unclutter &                    # mouse hider
nitrogen --restore &           # wallpaper setter
librewolf &                    # browser
signal-desktop &               # instant messenger
thunderbird &                  # mailclient
steam &                        # muh games
keepassxc &                    # password manager
#redshift -l                   # nightlight, set your own coordinates here
xcompmgr &                     # compositor
fcitx -d &                     # input method engine for Japanese
udiskie &                      # automatic disk mounting daemon
dunst &                        # notification daemon
lxqt-policykit-agent &         # polkit for authentication


# statusbar script
while true; do
        xsetroot -name "$(date "+%h %d %H:%M")"
        sleep 10
done &

exec dwm # ensure that this is always the last line
